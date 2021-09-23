//
//  NewsfeedWorker.swift
//  vkNewsClean
//
//  Created by Никита Ломовцев on 19.09.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsfeedService {

    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?

    init() {
        self.authService = SceneDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking, authService: authService )
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void){
        fetcher.getUser { user in
            completion(user)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void){
        fetcher.getFeed(nextBatchFrom: nil) {[weak self] feed in
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealedPostIds, feedResponse)
        }
    }
    
    func revealPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void){
        revealedPostIds.append(postId)
        guard let feedResponse = self.feedResponse else { return }
        completion(revealedPostIds, feedResponse)
    }
    
    func getNextBatch(completion: @escaping ([Int], FeedResponse) -> Void){
        newFromInProcess = feedResponse?.nextFrom
        fetcher.getFeed(nextBatchFrom: newFromInProcess) {[weak self] feed in
            guard let feed = feed else { return }
            guard self?.feedResponse?.nextFrom != feed.nextFrom else { return }
            
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            } else {
                self?.feedResponse?.items.append(contentsOf: feed.items)
                
                var profiles = feed.profiles
                if let oldProfiles = self?.feedResponse?.profiles{
                    let oldProfilesFiltered = oldProfiles.filter { oldProfile in
                        !feed.profiles.contains(where: {$0.id == oldProfile.id})
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self?.feedResponse?.groups{
                    let oldGroupsFiltered = oldGroups.filter { oldGroup in
                        !feed.groups.contains(where: {$0.id == oldGroup.id})
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
                
                self?.feedResponse?.nextFrom = feed.nextFrom
            }
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealedPostIds, feedResponse)
        }
    }
}
