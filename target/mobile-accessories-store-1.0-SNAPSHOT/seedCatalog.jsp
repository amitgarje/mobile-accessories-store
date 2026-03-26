<%@ page import="java.sql.*" %>
    <%@ page import="utils.DBConnection" %>
        <% String[] categories={ "Audio" , "Audio" , "Audio" , "Audio" , "Audio" , "Audio" , "Cables" , "Cables"
            , "Cables" , "Cables" , "Cables" , "Cables" , "PowerBars" , "PowerBars" , "PowerBars" , "PowerBars"
            , "Cases" , "Cases" , "Cases" , "Cases" , "ScreenProtectors" , "ScreenProtectors" , "ScreenProtectors"
            , "Accessories" , "Accessories" , "Accessories" , "Accessories" , "Accessories" , "Accessories"
            , "Accessories" , "Mounts" , "Mounts" , "Mounts" , "Mounts" , "Mounts" , "Accessories" , "Accessories"
            , "Accessories" , "Accessories" , "Accessories" , "Accessories" , "Accessories" , "Power" , "Power"
            , "Power" , "Audio" , "Audio" , "Cases" , "Cables" , "Accessories" , "Accessories" , "Accessories"
            , "Accessories" , "Accessories" }; String[] names={ "TWS Earbuds Pro" , "Wired Earphones (Type-C & 3.5mm)"
            , "Bluetooth Neckbands" , "Over-Ear Headphones" , "Portable Bluetooth Speakers" , "Smart Speakers"
            , "USB-C to USB-C Cables" , "USB-C to Lightning Cables" , "3-in-1 Multi-Charging Cables"
            , "Fast Charging Adapters (20W, 65W)" , "Multi-Port Car Chargers" , "OTG Adapters"
            , "High-Capacity Power Banks (10,000mAh+)" , "MagSafe Power Banks" , "Wireless Charging Pads"
            , "3-in-1 Charging Stations" , "Silicone Phone Cases" , "Hard-Shell Armor Cases"
            , "Clear Anti-Yellowing Covers" , "Leather Wallet Cases" , "9H Tempered Glass Screen Protectors"
            , "Matte/Privacy Screen Protectors" , "Camera Lens Protectors" , "Multi-Port USB-C Hubs/Dongles"
            , "Foldable Aluminum Laptop Stands" , "Wireless & Ergonomic Mice" , "Mechanical Keyboards"
            , "Laptop Sleeves & Bags" , "Webcam Privacy Covers" , "Desk Mats / Large Mouse Pads"
            , "Magnetic Car Air-Vent Mounts" , "Dashboard Phone Holders" , "PopSockets & Phone Rings"
            , "Flexible Tripods" , "Desktop Phone & Tablet Stands"
            , "Smartwatch Replacement Bands (Silicone, Nylon, Steel)" , "Smartwatch Bumper Cases & Screen Protectors"
            , "Smart Bluetooth Trackers (Item finders)" , "Clip-on LED Ring Lights (For vlogging)"
            , "UV Sanitizing Boxes" , "Cable Organizers & Cord Management Clips" , "Screen Cleaning Kits"
            , "Qi2 Magnetic Wireless Chargers" , "GaN (Gallium Nitride) Adapters" , "Transparent & Snap-On Power Banks"
            , "AI-Powered TWS Earbuds" , "Open-Ear & Bone Conduction Audio" , "Biodegradable Cases"
            , "Recycled Braided Cables" , "Smartphone Cooling Fans" , "Pro Mobile Triggers" , "AI Auto-Tracking Tripods"
            , "Magnetic RGB Fill Lights" , "Smart Rings" }; String[]
            definitions={ "Experience immense acoustic quality with spatial audio and noise cancellation."
            , "Durable, tangle-free wired audio options for zero latency."
            , "Comfortable wireless neckbands built for active lifestyles and deep bass."
            , "Premium over-ear headphones with 40-hour battery life and immersive soundstage."
            , "Rugged, waterproof portable speakers pumping vibrant sound anywhere."
            , "Voice-activated smart home assistants providing rich 360-degree sound."
            , "Durable, fast-charging 100W USB-C cables braided for longevity."
            , "Apple MFi-certified rugged cables for lightning-fast speeds."
            , "Charge your Android, iPhone, and accessories simultaneously with one cord."
            , "Ultra-fast compact GaN chargers that safely power phones and laptops."
            , "Keep your devices fully juiced on road trips with dual fast-charge ports."
            , "Seamlessly connect external drives to your phone with fast transfer speeds."
            , "Massive portable batteries that can charge your phone multiple times."
            , "Snap-on magnetic power banks designed exclusively for MagSafe iPhones."
            , "Sleek, wireless pads for drop-and-go Qi charging on your nightstand."
            , "Simultaneously charge your phone, smartwatch, and earbuds."
            , "Soft-touch liquid silicone providing excellent grip and drop protection."
            , "Military-grade armor cases with reinforced corners and kickstands."
            , "Show off your phone's true colors with tough anti-yellow polycarbonate."
            , "Premium vegan leather cases with card slots and RFID protection."
            , "Maximum scratch and impact resistance with oleophobic fingerprint coating."
            , "Keep your screen readable in the sun and private from peeping eyes."
            , "Precision-cut tempered glass to ensure your camera lenses stay flawless."
            , "Expand your laptop capabilities with 7-in-1 HDMI, USB, and SD interfaces."
            , "Ergonomic cooling metal stands to elevate your viewing angles."
            , "Precise tracking and comfort with modern minimalistic wireless mice."
            , "Tactile mechanical keyboards giving heavy typists the perfect feedback."
            , "Water-resistant, shock-absorbing sleeves protecting valuable tech inside."
            , "Ultra-thin camera slides ensuring total privacy when not recording."
            , "Premium anti-slip leather mats for smooth mousing and aesthetic desks."
            , "Securely snap your phone to your air vents using powerful magnets."
            , "Heavy-duty suction mounts delivering sturdy navigation angles."
            , "Collapsible grips giving you a firm hold and a reliable media stand."
            , "Wrap your camera or phone around any object with gorilla-style tripods."
            , "Adjustable aluminum stands for comfortable FaceTime and media viewing."
            , "Refresh your wearable style with premium sports or steel link bands."
            , "Defend your expensive smartwatch face against bumps and scratches."
            , "Never lose your keys or wallet again with global crowdsourced tracking."
            , "Flattering, bright ring lights that clip straight onto your smartphone."
            , "Sanitize your phone and keys automatically using UV-C light technology."
            , "Clean up desktop clutter with minimal, adhesive cable routing clips."
            , "Alcohol-free microfiber kits leaving screens flawlessly smudge-free."
            , "The new universal standard. MagSafe-like magnetic alignment for both iOS and Android."
            , "Ultra-compact high-wattage bricks (65W-100W) charging both laptop and phone without heat."
            , "Cyberpunk-aesthetic transparent battery packs showing internal circuitry."
            , "Next-gen audio featuring adaptive AI noise cancellation and real-time language translation."
            , "Listen to music while maintaining complete situational awareness. Perfect for fitness."
            , "Compostable cases made from wheat straw and recycled ocean plastic."
            , "Charging cables wrapped in recycled materials rather than PVC plastic."
            , "Snap-on semiconductor coolers with RGB lighting to stop gaming thermal throttling."
            , "Clip-on mechanical shoulder triggers and console grips for competitive gamers."
            , "Desk stands with sensors that rotate 360 degrees to track your face while recording."
            , "Pocket-sized adjustable LED lights that snap magnetically to your phone."
            , "Sleek minimalist rings that track sleep, heart rate, and steps discreetly." }; String[] String[] String[]
            images={ "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500"
            , "https://images.unsplash.com/photo-1583394838336-acd977736f90?w=500" , // ✅ Bluetooth Neckbands
            (FIXED) "https://images.unsplash.com/photo-1518444065439-e933c06ce9cd?w=500"
            , "https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500"
            , "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=500"
            , "https://images.unsplash.com/photo-1543512214-318c7553f230?w=500"
            , "https://images.unsplash.com/photo-1615526675159-e248c3021d3f?w=500" , // ✅ USB-C to
            Lightning "https://images.unsplash.com/photo-1584002652516-0adbcbc21ad3?w=500" , // ✅ 3-in-1
            Cable "https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=500"
            , "https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500" , // ✅ Car
            Charger "https://images.unsplash.com/photo-1555617117-08c0c6d0b75d?w=500"
            , "https://images.unsplash.com/photo-1517420704952-d9f39e95b43e?w=500"
            , "https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?w=500" , // ✅ MagSafe Power
            Bank "https://images.unsplash.com/photo-1623949556303-b0d17d198863?w=500"
            , "https://images.unsplash.com/photo-1616423640778-28d1b53229bd?w=500" , // ✅ Charging
            Station "https://images.unsplash.com/photo-1586940801646-6bf4f62ca54d?w=500"
            , "https://images.unsplash.com/photo-1603313011101-320f26a4f6f6?w=500" , // ✅ Hard-Shell Armor
            Cases "https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500" , // ✅ Clear Anti-Yellowing
            Covers "https://images.unsplash.com/photo-1601593346740-925612772716?w=500"
            , "https://images.unsplash.com/photo-1541560052-5e137f229371?w=500" , // ✅ Tempered
            Glass "https://images.unsplash.com/photo-1586953208448-b95a793c39af?w=500" , // ✅ Privacy
            Screen "https://images.unsplash.com/photo-1611078489935-0cb964de46d6?w=500" , // ✅ Camera Lens
            Protectors "https://images.unsplash.com/photo-1519183071298-a2962be90b8e?w=500" , // ✅ USB
            Hub "https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500"
            , "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=500"
            , "https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500"
            , "https://images.unsplash.com/photo-1595225476474-87563907a212?w=500"
            , "https://images.unsplash.com/photo-1583394838336-acd977736f90?w=500"
            , "https://images.unsplash.com/photo-1554415707-6e8cfc93fe23?w=500"
            , "https://images.unsplash.com/photo-1527443154391-507e9dc6c5cc?w=500"
            , "https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500"
            , "https://images.unsplash.com/photo-1615526675159-e248c3021d3f?w=500"
            , "https://images.unsplash.com/photo-1603313011101-320f26a4f6f6?w=500" , // ✅ Flexible
            Tripods "https://images.unsplash.com/photo-1510127034890-ba27508e9f1c?w=500" , // ✅ Desktop
            Stand "https://images.unsplash.com/photo-1587614382346-ac9b6c88b4f0?w=500"
            , "https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500" , // ✅ Smartwatch
            Protection "https://images.unsplash.com/photo-1517433456452-f9633a875f6f?w=500"
            , "https://images.unsplash.com/photo-1523206489230-c012c64b2b48?w=500" , // ✅ Ring
            Light "https://images.unsplash.com/photo-1587825140708-dfaf72ae4b04?w=500" , // ✅ UV Sanitizing
            Box "https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=500"
            , "https://images.unsplash.com/photo-1550009158-9ffcb563d76e?w=500" , // ✅ Screen Cleaning
            Kit "https://images.unsplash.com/photo-1581574204013-1b31c06a6d05?w=500"
            , "https://images.unsplash.com/photo-1584002652516-0adbcbc21ad3?w=500"
            , "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500"
            , "https://images.unsplash.com/photo-1622445272461-c458022d1eb9?w=500"
            , "https://images.unsplash.com/photo-1616423640778-28d1b53229bd?w=500"
            , "https://images.unsplash.com/photo-1583863788434-e58a36330cf0?w=500"
            , "https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?w=500"
            , "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=500"
            , "https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500"
            , "https://images.unsplash.com/photo-1603313011101-320f26a4f6f6?w=500"
            , "https://images.unsplash.com/photo-1615526675159-e248c3021d3f?w=500" , // ✅ Pro Mobile
            Triggers "https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=500" , // ✅ AI Auto Tracking
            Tripod "https://images.unsplash.com/photo-1598550880863-4e8aa3d0f3e3?w=500" , // ✅ RGB Fill
            Light "https://images.unsplash.com/photo-1603575448369-7df8a5f1b9c6?w=500"
            , "https://images.unsplash.com/photo-1526408253131-ab1bc24bbbc8?w=500"
            , "https://images.unsplash.com/photo-1518556606041-3d7ca9dfdc6f?w=500"
            , "https://images.unsplash.com/photo-1550009158-9ffcb563d76e?w=500"
            , "https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=500" }; %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Seeded Database</title>
            </head>

            <body>
                <h1>Seeding Complete</h1>
                <p>Successfully inserted <%= successCount %> products into the database.</p>
                <a href="index.jsp">Go back to Homepage</a>
            </body>

            </html>