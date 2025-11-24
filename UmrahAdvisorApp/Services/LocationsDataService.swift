//
//  LocationsDataService.swift
//  MapTest
//
//  Created by Nick Sarno on 11/26/21.
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            locationNumber: "1",
            name: "Masjid al-Haram",
            cityName: "Makkah",
            coordinates: CLLocationCoordinate2D(latitude: 21.4225, longitude: 39.8262),
            LocationDetailData: [
                LocationDetailData(title: "The Grand Mosque in Mecca", description: ["Masjid al-Haram, often called The Grand Mosque, is the most sacred and largest mosque in the world. It is located in Mecca, Saudi Arabia, and surrounds the Kaaba, which is the holiest site in Islam. Every Muslim around the world faces the Kaaba during their daily prayers, making the mosque the spiritual center of Islam."]),
                LocationDetailData(title: "📜 Historical Background", description: ["The Kaaba (the cube-shaped structure at the center of the mosque) is believed to have been originally built by Prophet Ibrahim (Abraham) and his son Ismail (Ishmael) on the command of Allah.", "The Qur’an mentions this when Ibrahim and Ismail raised the foundations of the Kaaba, making it a place of worship for all mankind.", "Over centuries, the Kaaba and Masjid al-Haram have been rebuilt and expanded many times due to floods, wear, and the increasing number of worshippers.", "During the time of Prophet Muhammad (peace be upon him) in the 7th century, the Kaaba was restored to its monotheistic purpose after years of misuse by pagans who placed idols around it."]),
                LocationDetailData(title: "🌟 Religious Significance", description: ["Center of Worship (Qibla): Muslims across the globe face the Kaaba in Masjid al-Haram while praying, symbolizing unity and direction in worship.", "Hajj and Umrah: Masjid al-Haram is the focal point of Hajj, the fifth pillar of Islam, which is obligatory for every able Muslim once in their lifetime. It is also central to Umrah, the lesser pilgrimage that can be performed at any time of the year.", "Sacred Acts of Worship: Pilgrims perform Tawaf (circumambulating the Kaaba), Sa’i (walking between Safa and Marwa), and drink from Zamzam water, all of which are located within the mosque.", " Spiritual Merit: Prayers performed inside Masjid al-Haram carry immense reward. According to Hadith, one prayer in the Grand Mosque is equal to 100,000 prayers offered elsewhere."]),
                LocationDetailData(title: "🕌 Architectural Development", description: ["Early expansions began under the caliphs after the Prophet’s time, with notable contributions from the Umayyad and Abbasid dynasties.", "The Ottoman Empire further enhanced the mosque with domes, minarets, and marble flooring.", "In the modern era, Saudi Arabia has undertaken massive projects to expand the mosque to accommodate millions of worshippers. These include multi-level prayer halls, air-conditioning, escalators, tunnels, and advanced crowd management systems.", "Today, Masjid al-Haram is not only the largest mosque but also one of the most sophisticated religious complexes in the world."])
            ],
            imageNames: [
                "Masjid al-Haram1",
                "Masjid al-Haram2",
                "Masjid al-Haram3",
            ]
        ),
        Location(
            locationNumber: "2",
            name: "Mina",
            cityName: "Makkah",
            coordinates: CLLocationCoordinate2D(latitude: 21.4241, longitude: 39.9277),
            LocationDetailData: [
                LocationDetailData(
                    title: "The Tent City",
                    description: [
                        "Mina is a vast tent city located east of Mecca, Saudi Arabia. It is one of the most significant places during the annual Hajj pilgrimage. Each year, millions of pilgrims travel to Mina to stay in specially prepared tents, making it one of the largest temporary cities in the world."
                    ]
                ),
                LocationDetailData(
                    title: "📜 Historical Background",
                    description: [
                        "Mina has been a central part of the Hajj journey since the time of Prophet Ibrahim (Abraham).",
                        "It is here that Prophet Ibrahim prepared to sacrifice his son Ismail in obedience to Allah’s command, a story remembered through the ritual of stoning the pillars (Jamarat).",
                        "Throughout Islamic history, Mina has been the location where pilgrims gather, rest, and perform the essential rites of Hajj.",
                        "Over centuries, Mina has transformed from a desert valley to a highly organized tent city with modern infrastructure."
                    ]
                ),
                LocationDetailData(
                    title: "🌟 Religious Significance",
                    description: [
                        "Stoning of the Devil (Ramy al-Jamarat): The most significant ritual in Mina, where pilgrims throw pebbles at three stone pillars, symbolizing rejection of Satan’s temptations.",
                        "Sacrifice (Qurbani): Many pilgrims offer an animal sacrifice in Mina during Eid al-Adha, commemorating Prophet Ibrahim’s devotion and obedience to Allah.",
                        "Mandatory Stay: Pilgrims spend the nights in Mina as part of the rituals of Hajj, reflecting patience, unity, and remembrance of Allah.",
                        "Mina serves as a reminder of the struggle against temptation and complete submission to Allah’s will."
                    ]
                ),
                LocationDetailData(
                    title: "🏕️ The Tent City",
                    description: [
                        "Today, Mina is filled with more than 100,000 air-conditioned, fireproof tents that can accommodate millions of pilgrims.",
                        "The tents are arranged in an organized grid system with facilities for food, healthcare, and sanitation.",
                        "The development of Mina as a modern tent city reflects Saudi Arabia’s efforts to provide safety, comfort, and organization for pilgrims during the intense days of Hajj."
                    ]
                ),
                LocationDetailData(
                    title: "🌍 Why Mina Is Famous",
                    description: [
                        "It is the site of the symbolic stoning of the devil, one of the most important rituals of Hajj.",
                        "It is known as the world’s largest tent city, housing millions of pilgrims at one time.",
                        "It connects deeply to the story of Prophet Ibrahim’s sacrifice, making it a place of spiritual reflection and obedience.",
                        "Mina symbolizes unity, sacrifice, and steadfastness in faith for Muslims around the world."
                    ]
                )
            ],
            imageNames: [
                "Mina1",
                "Mina2",
                "Mina3",
            ]
        ),
        Location(
            locationNumber: "3",
            name: "Arafat",
            cityName: "Makkah",
            coordinates: CLLocationCoordinate2D(latitude: 21.3440, longitude: 39.9740),
            LocationDetailData: [
                LocationDetailData(
                    title: "The Plain of Mercy",
                    description: [
                        "Arafat is a vast plain located southeast of Mecca, Saudi Arabia, and is one of the holiest sites in Islam. It is the central location of the most important ritual of Hajj, known as Wuquf (standing in Arafat). Every year on the 9th of Dhul-Hijjah, millions of pilgrims gather here in prayer, humility, and supplication."
                    ]
                ),
                LocationDetailData(
                    title: "📜 Historical Background",
                    description: [
                        "Arafat holds deep historical significance dating back to the time of Prophet Ibrahim (Abraham) and Prophet Muhammad (peace be upon him).",
                        "According to Islamic tradition, Arafat is the place where Prophet Adam and Hawa (Eve) reunited on Earth after being sent down from Paradise, which is why it is also called the 'Plain of Mercy'.",
                        "Most importantly, it is the site where Prophet Muhammad (peace be upon him) delivered his famous Farewell Sermon (Khutbat al-Wada') during his last Hajj in the year 632 CE.",
                        "In his sermon, the Prophet emphasized equality, justice, and the rights and duties of Muslims, making Arafat a place of remembrance and guidance."
                    ]
                ),
                LocationDetailData(
                    title: "🌟 Religious Significance",
                    description: [
                        "Wuquf at Arafat: Standing in prayer and supplication in Arafat on the 9th of Dhul-Hijjah is the most essential part of Hajj. Without it, the pilgrimage is invalid.",
                        "Day of Arafah: This day is considered the holiest day in the Islamic calendar, and fasting on this day (for those not performing Hajj) carries immense reward.",
                        "Unity and Equality: Pilgrims of every background stand together in simple white garments (Ihram), symbolizing the equality of all before Allah.",
                        "Spiritual Renewal: It is a day of seeking forgiveness, mercy, and renewal of one’s faith."
                    ]
                ),
                LocationDetailData(
                    title: "🕌 Jabal al-Rahmah (Mount of Mercy)",
                    description: [
                        "At the center of Arafat lies Jabal al-Rahmah, or the Mount of Mercy.",
                        "It is said to be the spot where Prophet Muhammad (peace be upon him) delivered his Farewell Sermon.",
                        "Pilgrims gather around the mountain to pray, supplicate, and seek forgiveness, making it one of the most spiritually charged places in Islam."
                    ]
                ),
                LocationDetailData(
                    title: "🌍 Why Arafat Is Famous",
                    description: [
                        "It is the site of Wuquf, the most important ritual of Hajj.",
                        "It is where Prophet Muhammad (peace be upon him) delivered his Farewell Sermon.",
                        "It symbolizes mercy, forgiveness, and equality among Muslims.",
                        "The Day of Arafah is one of the most spiritually significant days in Islam, even for those not performing Hajj."
                    ]
                )
            ],
            imageNames: [
                "Arafat1",
                "Arafat2",
                "Arafat3",
            ]
        ),
        Location(
            locationNumber: "4",
            name: "Muzdalifah",
            cityName: "Makkah",
            coordinates: CLLocationCoordinate2D(latitude: 21.4246, longitude: 39.9182),
            LocationDetailData: [
                LocationDetailData(
                    title: "The Sacred Plain",
                    description: [
                        "Muzdalifah is a vast open plain located between Mina and Arafat, in the holy city of Mecca, Saudi Arabia. It is an essential stop for pilgrims during the Hajj journey, observed right after leaving Arafat on the 9th of Dhul-Hijjah. The area is simple and humble, reflecting the essence of Hajj as a journey of faith, equality, and devotion."
                    ]
                ),
                LocationDetailData(
                    title: "📜 Historical Background",
                    description: [
                        "Muzdalifah has been a gathering point for Hajj pilgrims since the time of Prophet Ibrahim (Abraham, peace be upon him).",
                        "Prophet Muhammad (peace be upon him) also stayed here during his Farewell Hajj, teaching the rituals to his companions.",
                        "The tradition of spending the night here has been carried on by millions of pilgrims for centuries, making it one of the core sites of Hajj."
                    ]
                ),
                LocationDetailData(
                    title: "🌟 Religious Significance",
                    description: [
                        "Overnight Stay: Pilgrims are required to spend the night in Muzdalifah after leaving Arafat, engaging in prayer, rest, and reflection.",
                        "Collecting Pebbles: Pilgrims gather small pebbles here, which will later be used for the symbolic stoning of the devil ritual (Ramy al-Jamarat) in Mina.",
                        "Unity and Simplicity: Pilgrims rest under the open sky, without tents or luxuries, symbolizing humility, equality, and reliance on Allah."
                    ]
                ),
                LocationDetailData(
                    title: "🕌 Key Practices in Muzdalifah",
                    description: [
                        "Performing Maghrib and Isha prayers together after arriving from Arafat.",
                        "Spending the night in worship, remembrance, or rest under the open sky.",
                        "Collecting 49 or 70 small pebbles for the stoning ritual at Mina.",
                        "Leaving Muzdalifah for Mina after Fajr prayer on the 10th of Dhul-Hijjah."
                    ]
                ),
                LocationDetailData(
                    title: "🌍 Why Muzdalifah Is Famous",
                    description: [
                        "It is the connecting plain between Arafat and Mina in the Hajj journey.",
                        "The place where pilgrims spend the night under the open sky, in complete equality.",
                        "The site for collecting pebbles for the symbolic stoning ritual.",
                        "A reminder of simplicity, humility, and spiritual devotion in Hajj."
                    ]
                )
            ],
            imageNames: [
                "Muzdalifah1",
                "Muzdalifah2",
            ]
        ),
        Location(
            locationNumber: "5",
            name: "Masjid al-Nabawi",
            cityName: "Madinah",
            coordinates: CLLocationCoordinate2D(latitude: 24.4709, longitude: 39.6114),
            LocationDetailData: [
                LocationDetailData(
                    title: "The Prophet’s Mosque",
                    description: [
                        "Masjid al-Nabawi, located in Medina, Saudi Arabia, is the second holiest mosque in Islam after Masjid al-Haram in Mecca. It was originally built by Prophet Muhammad (peace be upon him) after his migration (Hijrah) from Mecca to Medina in 622 CE. The mosque is the final resting place of the Prophet, making it one of the most sacred and visited sites in the world."
                    ]
                ),
                LocationDetailData(
                    title: "📜 Historical Background",
                    description: [
                        "Masjid al-Nabawi was established by the Prophet Muhammad (peace be upon him) shortly after arriving in Medina.",
                        "Initially a simple structure made of mud walls and palm trunks, it served as a place of worship, community gatherings, education, and administration.",
                        "The Prophet lived adjacent to the mosque, and after his passing, he was buried in the chamber of his wife Aisha, which is now part of the mosque complex.",
                        "Over the centuries, various Muslim rulers expanded and beautified the mosque, making it a grand and revered sanctuary."
                    ]
                ),
                LocationDetailData(
                    title: "🌟 Religious Significance",
                    description: [
                        "Second Holiest Mosque: It holds immense importance after Masjid al-Haram in Mecca.",
                        "Resting Place of the Prophet: The Prophet Muhammad (peace be upon him) is buried here, along with his close companions Abu Bakr and Umar (may Allah be pleased with them).",
                        "Place of Immense Reward: According to Hadith, one prayer in Masjid al-Nabawi is better than a thousand prayers offered elsewhere (except in Masjid al-Haram).",
                        "Spiritual Center: Muslims visit the mosque to pray, reflect, and send salutations upon the Prophet."
                    ]
                ),
                LocationDetailData(
                    title: "🕌 Architectural Development",
                    description: [
                        "The mosque has undergone many expansions since the Prophet’s time, from the Rashidun Caliphs to the Ottoman Empire, and now under Saudi leadership.",
                        "Its most iconic feature is the Green Dome, built above the chamber where the Prophet is buried.",
                        "The mosque today features multiple domes, towering minarets, marble courtyards, and a retractable roof system.",
                        "It can accommodate over a million worshippers, especially during Hajj and Ramadan seasons."
                    ]
                ),
                LocationDetailData(
                    title: "🌍 Why Masjid al-Nabawi Is Famous",
                    description: [
                        "It is the second holiest mosque in Islam, after Masjid al-Haram.",
                        "The Prophet Muhammad’s (peace be upon him) tomb is located within the mosque.",
                        "It is a symbol of love, reverence, and unity among Muslims worldwide.",
                        "The Green Dome is one of the most iconic landmarks in Islamic history and architecture.",
                        "It continues to serve as a place of worship, learning, and spiritual connection for millions of visitors every year."
                    ]
                )
            ],
            imageNames: [
                "Masjid al-Nabawi1",
                "Masjid al-Nabawi2",
                "Masjid al-Nabawi3",
            ]
        ),
        Location(
            locationNumber: "6",
            name: "Quba Mosque",
            cityName: "Madinah",
            coordinates: CLLocationCoordinate2D(latitude: 24.4032, longitude: 39.5616),
            LocationDetailData: [
                LocationDetailData(
                    title: "The First Mosque in Islam",
                    description: [
                        "Quba Mosque, located in Medina, Saudi Arabia, is the first mosque built by Prophet Muhammad (peace be upon him) after his migration (Hijrah) from Mecca. Its foundation was laid in the year 622 CE, marking the beginning of a new era for the Muslim community. The mosque holds immense historical and spiritual value, as it reflects the unity, faith, and devotion of the early Muslims."
                    ]
                ),
                LocationDetailData(
                    title: "📜 Historical Background",
                    description: [
                        "When Prophet Muhammad (peace be upon him) arrived in Quba, a small village near Medina, he stayed for several days before entering the city.",
                        "During this time, he and his companions laid the foundation of Quba Mosque, making it the very first mosque in Islam.",
                        "Initially, it was a simple structure built with mud bricks and palm trunks, but it became a central place of worship and community gathering.",
                        "Over centuries, various Muslim rulers and dynasties expanded and renovated the mosque to preserve its importance."
                    ]
                ),
                LocationDetailData(
                    title: "🌟 Religious Significance",
                    description: [
                        "The Prophet Muhammad (peace be upon him) emphasized the virtue of visiting and praying in Quba Mosque.",
                        "According to Hadith: 'Whoever purifies himself in his house, then comes to Masjid Quba and prays in it, he will have a reward like that of Umrah.' (Ibn Majah, Nasa’i).",
                        "Muslims visit Quba Mosque to offer prayers and seek blessings, considering it a place of great barakah (blessing).",
                        "It serves as a reminder of the early struggles and sacrifices of the first Muslim community."
                    ]
                ),
                LocationDetailData(
                    title: "🕌 Architectural Development",
                    description: [
                        "The mosque has undergone several reconstructions throughout history, with major contributions during the time of Caliph Umar ibn Al-Khattab and Caliph Uthman ibn Affan.",
                        "The Ottoman Empire later expanded and beautified the mosque, adding domes and minarets.",
                        "In modern times, the mosque has been renovated extensively under the Kingdom of Saudi Arabia.",
                        "Today, Quba Mosque is a large, beautifully designed structure featuring multiple domes, marble flooring, and prayer areas for thousands of worshippers."
                    ]
                ),
                LocationDetailData(
                    title: "🌍 Why Quba Mosque Is Famous",
                    description: [
                        "It is the first mosque in the history of Islam, personally founded by Prophet Muhammad (peace be upon him).",
                        "Praying in Quba Mosque carries the reward of performing Umrah, as mentioned in Hadith.",
                        "It stands as a symbol of the Hijrah (migration) and the establishment of the first Muslim community in Medina.",
                        "It is one of the most visited sites by pilgrims in Medina, after Masjid al-Nabawi."
                    ]
                )
            ],
            imageNames: [
                "Quba Mosque1",
                "Quba Mosque2",
                "Quba Mosque3",
            ]
        ),
        Location(
            locationNumber: "7",
            name: "Uhud Mountain",
            cityName: "Madinah",
            coordinates: CLLocationCoordinate2D(latitude: 24.4831, longitude: 39.5702),
            LocationDetailData: [
                LocationDetailData(
                    title: "Symbol of Faith and Sacrifice",
                    description: [
                        "Uhud Mountain is located north of Medina, Saudi Arabia, and is one of the most famous mountains in Islamic history. It is best known as the site of the Battle of Uhud, which took place in 625 CE (3 AH) between the early Muslims of Medina and the Quraysh tribe of Mecca. The mountain stands as a lasting reminder of sacrifice, perseverance, and faith in the face of trials."
                    ]
                ),
                LocationDetailData(
                    title: "📜 Historical Background",
                    description: [
                        "The Battle of Uhud occurred one year after the Battle of Badr, when the Quraysh sought revenge for their defeat.",
                        "Initially, the Muslims gained the upper hand, but due to a group of archers disobeying the Prophet’s command and leaving their positions, the Quraysh were able to counterattack.",
                        "Many companions, including Hamzah ibn Abdul-Muttalib (the uncle of the Prophet), were martyred in this battle.",
                        "The Qur’an refers to the events of Uhud in Surah Aal-e-Imran, highlighting its lessons of patience, unity, and obedience."
                    ]
                ),
                LocationDetailData(
                    title: "🌟 Religious Significance",
                    description: [
                        "Prophet Muhammad (peace be upon him) expressed deep love for Uhud Mountain, saying: 'Uhud is a mountain which loves us and we love it.' (Sahih Bukhari).",
                        "The martyrs of Uhud, especially Hamzah ibn Abdul-Muttalib, are honored and remembered by Muslims worldwide.",
                        "The site teaches important lessons about steadfastness, discipline, and the consequences of disobedience.",
                        "Visiting Uhud is a way for pilgrims to reflect on the sacrifices made by the early Muslims for the preservation of Islam."
                    ]
                ),
                LocationDetailData(
                    title: "🕌 Memorial and Visits",
                    description: [
                        "A cemetery near Uhud Mountain is the burial place of many martyrs of the battle, including Hamzah ibn Abdul-Muttalib.",
                        "Pilgrims who visit Medina often travel to Uhud to offer prayers and pay respects to the martyrs.",
                        "The mountain and its surrounding area remain a spiritual and historical landmark, reminding Muslims of the trials faced by the early community."
                    ]
                ),
                LocationDetailData(
                    title: "🌍 Why Uhud Mountain Is Famous",
                    description: [
                        "It is the site of the historic Battle of Uhud, one of the most important battles in Islamic history.",
                        "It is closely associated with the life of Prophet Muhammad (peace be upon him) and his companions.",
                        "The mountain symbolizes endurance, struggle, and the love between the Prophet and his followers.",
                        "Today, it is one of the most visited historical sites in Medina, drawing millions of pilgrims annually."
                    ]
                )
            ],
            imageNames: [
                "Uhud Mountain1",
                "Uhud Mountain2",
            ]
        ),
    ]
    
}
