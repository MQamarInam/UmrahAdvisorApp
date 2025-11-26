//
//  UmrahGuideService.swift
//  UmrahAdvisorApp
//
//  Created by Qaim's Macbook  on 26/11/2025.
//

import Foundation

class UmrahGuideService: UmrahGuideServiceProtocol {

    private let storageKey = "UmrahSteps"

    func loadStep() -> [UmrahStep] {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([UmrahStep].self, from: data) {
            return decoded
        }
        return [
            UmrahStep(
                title: "Miqat Info.",
                description: [
                    "Miqat refers to the specific boundary points around Makkah that pilgrims must not cross without entering into the state of Ihram. These boundaries were set by the Prophet Muhammad ﷺ.",
                    "There are five main Miqats, each designated for pilgrims coming from different regions:",
                    "1. Dhul-Hulaifah (Abyar Ali) – For those coming from Medina direction.",
                    "2. Al-Juhfah – For those coming from the Levant (Syria, Jordan, Palestine) and Egypt.",
                    "3. Qarn al-Manazil (As-Sail al-Kabir) – For those coming from Najd (central Arabia).",
                    "4. Yalamlam – For those coming from Yemen and southern regions.",
                    "5. Dhat Irq – For those coming from Iraq and northeastern regions.",
                    "Steps to Perform at Miqat:",
                    "Perform Ghusl (full ritual purification) or Wudu.",
                    "Wear the Ihram garments: two unstitched white sheets for men; loose, modest clothing for women.",
                    "Offer two Raka’ah of Salah (optional but highly recommended).",
                    "Make the intention (Niyyah) for Hajj or Umrah. Example: لَبَّيْكَ عُمْرَةً Labbayka ‘Umrah (Here I am for Umrah).",
                    "Start reciting the Talbiyah: لَبَّيْكَ اللّهُمَّ لَبَّيْكَ... continuously until reaching the Kaaba.",
                    "Importance of Miqat:",
                    "- It marks the starting point of the sacred pilgrimage journey.",
                    "- Crossing it without Ihram is not permissible and requires a penalty (Dam).",
                    "- Symbolizes spiritual readiness and equality among pilgrims."
                ],
            ),
            UmrahStep(title: "Perform Ghusl", description: [
                "Think in your heart that you are doing Ghusl to purify yourself for Allah.",
                "Start by saying Bismillah before beginning the purification.",
                "Wash both hands up to the wrists three times and Make sure water reaches everywhere.",
                "Rinse your mouth three times.",
                "Rinse your nose three times by sniffing water gently and blowing it out.",
                "Pour water over your entire body, starting with the right side, then the left and Ensure water reaches all parts of your body, including under the hair, armpits, and between fingers and toes.",
                "Make sure no spot on your body remains dry."
            ]),
            UmrahStep(title: "Wearing Ihram", description: [
                "Upper garment for Men (Rida): A plain, white, unstitched cloth wrapped over the shoulders and covering the upper body.",
                "Lower garment for Men (Izar): A similar unstitched cloth wrapped around the waist, covering from the navel to the ankles.",
                "Footwear for Men: Open sandals or slippers that do not cover the ankles and the top of the feet.",
                "Women wear their regular modest clothing that covers their entire body, except the face and hands. Avoid any sewn garments that are decorative or tight-fitting. Do not cover the face (using a niqab) or hands (using gloves).",
                "After wearing the Ihram garments, make the intention (Niyyah) for Umrah. Stand facing the Qibla (Kaaba) and say in your heart the purpose of your Ihram ( Labbaik Umrah لَبَّيْكَ عُمْرَةً).",
                "After making your intention, immediately recite the Talbiyah.  Labbaik Allahumma Labbaik, Labbaik Laa Shareeka Laka Labbaik, Innal Hamda Wan-Ni'mata Laka Wal-Mulk, Laa Shareeka Laka"
            ]),
            UmrahStep(title: "Two Rakat Nafal", description: [
                "After wearing Ihram and making the Niyyah (intention) for Umrah, it is Sunnah to perform two Rak‘at Nafl prayer before starting Tawaf.",
                "Stand facing the Qiblah (towards the Kaaba) with humility and devotion.",
                "In the first Rak‘at, after reciting Surah Al-Fatiha, recite Surah Al-Kafirun (قُلْ يَا أَيُّهَا الْكَافِرُونَ).",
                "In the second Rak‘at, after Surah Al-Fatiha, recite Surah Al-Ikhlas (قُلْ هُوَ اللَّهُ أَحَدٌ).",
                "Recite all with proper concentration, seeking closeness to Allah and preparing your heart for Tawaf.",
                "After completing the two Rak‘at, raise your hands in du‘a and sincerely ask Allah for acceptance of your Umrah, forgiveness, and ease in completing all rituals.",
                "Now you are spiritually prepared to begin Tawaf by proceeding towards the Kaaba."
            ]),
            UmrahStep(title: "Tawaf", description: [
                "Tawaf is the act of circling the Kaaba seven times in an anti-clockwise direction, a vital part of Umrah and Hajj rituals. It symbolizes unity, devotion, and submission to Allah.",
                "Stand at the starting point of Tawaf (near the Black Stone, known as Hajar al-Aswad). In your heart, make the intention to perform Tawaf solely for the sake of Allah. Example: (O Allah, I intend to perform Tawaf to seek Your pleasure and nearness).",
                "Locate the Black Stone embedded in one corner of the Kaaba. Stand parallel to it, facing the Kaaba. Raise your right hand and say: سْمِ اللَّهِ وَاللَّهُ أَكْبَرُ . If possible, lightly touch or kiss the Black Stone. If it is too crowded, simply gesture towards it with your right hand.",
                "Walk around the Kaaba anti-clockwise. Keep the Kaaba on your left side throughout the Tawaf. Move at a steady pace without pushing or shoving others.",
                "There are no fixed prayers, but the following is commonly recited: SubhanAllah, walhamdulillah, wa la ilaha illallah, wallahu Akbar.",
                "Each round starts and ends at the Black Stone. Count each circuit carefully to ensure you complete all seven. Avoid distractions and focus on your worship.",
                "After completing the seventh circuit, stop near the Black Stone. Again, raise your hand and say: Bismillah Allahu Akbar.",
                "If space allows, pray two Rakat behind Maqam Ibrahim (the Station of Ibrahim), located near the Kaaba. Recite Surah Al-Fatiha and any other Surah during these Rakats."
            ]),
            UmrahStep(title: "Drink Zamzam Water", description: [
                "Drinking Zamzam water is an essential Sunnah during Umrah or Hajj, as it is believed to hold immense spiritual and physical benefits.",
                "Zamzam water is readily available near the Kaaba, at the Masjid al-Haram, and at designated Zamzam dispensers around the mosque.",
                "Make an Intention: In your heart, intend to drink Zamzam water for seeking Allah's blessings, healing, or fulfillment of a specific need. (O Allah, I am drinking this water to seek Your blessings and mercy).",
                "Before drinking, say: بِسْمِ اللَّهِ Bismillah (In the name of Allah).",
                "Turn towards the Kaaba (Qibla) when drinking, as this is a Sunnah. Hold the cup in your right hand.",
                "Drink Zamzam water slowly, in three sips, rather than gulping it all at once. This follows the Sunnah of the Prophet Muhammad (peace be upon him), who encouraged drinking in intervals.",
                "After drinking Zamzam water, make Dua (supplication). It is narrated that Zamzam water fulfills the purpose for which it is drunk. Use this opportunity to ask Allah for your wishes, forgiveness, good health, and success.",
                "Example Dua: اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا وَاسِعًا، وَشِفَاءً مِنْ كُلِّ دَاءٍ"
            ]),
            UmrahStep(title: "Perform Sa'i", description: [
                "Sa'i is the act of walking seven times between the hills of Safa and Marwah, symbolizing Hajar's search for water for her son Ismail. It is an essential part of Hajj and Umrah.",
                "Stand at Safa, facing the Kaaba. Raise your hands and say: إِنَّ الصَّفَا وَالْمَرْوَةَ مِن شَعَائِرِ اللَّهِ Innas-Safa wal-Marwata min Sha'a'irillah",
                "Praise Allah and say: اللَّهُ أَكْبَرُ، اللَّهُ أَكْبَرُ، اللَّهُ أَكْبَرُ Allahu Akbar, Allahu Akbar, Allahu Akbar. Make personal Duas and ask for forgiveness.",
                "Begin walking from Safa towards Marwah at a normal pace. Engage in Dua, Dhikr (remembrance of Allah), or recite Quranic verses.",
                "Upon reaching Marwah, stop, face the Kaaba, and raise your hands. Praise Allah and make Dua as you did at Safa. This completes one circuit.",
                "Walk back to Safa from Marwah following the same steps. Count each round carefully, as one complete round consists of traveling from Safa to Marwah (and vice versa).",
                "Repeat the process of walking between Safa and Marwah until you complete seven circuits. The first trip is from Safa to Marwah. The seventh trip ends at Marwah.",
                "Once you finish the seventh round at Marwah, thank Allah for allowing you to complete this act of worship. Make Dua for yourself, your loved ones, and the Ummah."
            ]),
            UmrahStep(title: "Halq/Taqsir", description: [
                "Halq (shaving the head) or Taqsir (trimming the hair) is the final step in completing your Umrah. It symbolizes humility, submission to Allah, and the shedding of sins.",
                "Halq: Shaving the entire head (preferred for men as it carries more reward). Taqsir: Trimming a portion of the hair (suitable for women and men who do not wish to shave).",
                "Visit a designated barber near the Haram or an approved area for shaving. Ensure that the barber uses a clean and sterilized blade for hygiene. The barber will shave all the hair on your head. Ensure that no part of the head is left unshaved.",
                "After shaving, thank Allah and make Dua. You can say: اللَّهُمَّ اغْفِرْ لِي وَارْحَمْنِي",
                "For women, gather a small portion of hair and cut about an inch (or the length of a fingertip). Women should ensure their trimming is done in a private or covered area, avoiding public display.",
                "This act is symbolic of leaving behind sins and worldly attachments. Do not rush; ensure the Halq or Taqsir is completed properly."
            ]),
            UmrahStep(title: "Remove Ihram", description: [
                "Removing Ihram is the final step in completing your Umrah after performing Halq (shaving the head) or Taqsir (trimming the hair). It symbolizes the end of the sacred state of Ihram and a return to normal life.",
                "Before removing Ihram, ensure that you have completed all essential rituals of Umrah: Tawaf (circumambulation around the Kaaba). Sa'i (walking between Safa and Marwah). Halq (shaving) or Taqsir (trimming).",
                "For Men: Take off the two white Ihram garments (upper Rida and lower Izar). Change into your regular clothes.",
                "Women do not wear specific Ihram garments but ensure they are dressed modestly and can now return to their usual attire.",
                "Pray two Rakat of gratitude to thank Allah for allowing you to complete Umrah. Make heartfelt Duas for yourself, your family, and the Ummah.",
                "Use this opportunity to reflect on the spiritual journey you have just completed. Make a commitment to continue practicing good deeds and staying closer to Allah."
            ])
        ]
    }

    func saveStep(_ steps: [UmrahStep]) {
        if let encoded = try? JSONEncoder().encode(steps) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
}
