//
//  ViewController.swift
//  pokedex3
//
//  Created by Le Anh Duc on 3/20/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    var pokemons = [Pokemon]()
    var fillter = [Pokemon]()
    var isFilltered = false
    var player:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate   = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "Bienvang", ofType: "mp3")
        
        do {
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
    }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let name = row["identifier"]!
                let pokeID = Int(row["id"]!)!
                
                let poke = Pokemon(name: name, id: pokeID)
                
                pokemons.append(poke)
                
            }
            
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFilltered {
            
            return fillter.count
            
        } else {
            
            return pokemons.count
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let pokemon:Pokemon
            if isFilltered {
                
                pokemon = fillter[indexPath.row]
                
            }else {
                
                pokemon = pokemons[indexPath.row]
                
            }
            cell.configureCell(pokemon)
            return cell
            
        } else {
            
            return UICollectionViewCell()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("selected item")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: 105, height: 105)
        
    }

    @IBAction func musicPressed(_ sender: Any) {
        
        if player.isPlaying{
            
            player.pause()
            musicButton.alpha = 0.2
            
        } else {
            
            player.play()
            musicButton.alpha = 1
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            isFilltered = false
            
        } else {
            
            isFilltered = true
            let lower = searchBar.text!.lowercased()
            fillter = pokemons.filter({$0.name.range(of: lower) != nil})
            
        }
        collection.reloadData()
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
}

