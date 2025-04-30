AAE6102 Assignment2 report

## Task 1 – Differential GNSS Positioning

Write a short essay (500–1000 words) comparing the pros and cons of the following GNSS techniques for smartphone navigation:

Differential GNSS (DGNSS)

Real-Time Kinematic (RTK)

Precise Point Positioning (PPP)

PPP-RTK

**Model:** Perplexity.AI

**Comment:** It helps me better clarify the concepts, find reference materials, and integrate information to complete the task.

**Chatroom Link:** <a name="ole_link11"></a><a name="ole_link12"></a>https://www.perplexity.ai/search/can-you-explain-the-basic-conc-1ctOtrgKQfKMqQZe7sQ5Bg

<a name="ole_link6"></a>Differential GNSS (DGNSS), Real-Time Kinematic (RTK), Precise Point Positioning (PPP), and PPP-RTK are advanced GNSS augmentation techniques designed to improve positioning accuracy beyond what standalone GNSS receivers typically achieve. When applied to smartphone navigation, each method offers distinct benefits and faces specific challenges related to precision, cost, and infrastructure requirements. This essay compares these four techniques in the context of smartphone use.

**Precision**

DGNSS enhances positioning by applying corrections from nearby reference stations to reduce satellite and atmospheric errors. On smartphones, DGNSS can improve horizontal accuracy to about 1.75 meters and vertical accuracy to roughly 4.5 meters using L5 differential corrections. This represents a significant improvement over standalone GNSS, which often yields errors of several meters. However, smartphone GNSS antennas are typically linearly polarized and optimized for voice rather than navigation signals, making them prone to multipath interference and noisy measurements. These hardware limitations restrict DGNSS’s ability to reach sub-meter or centimeter-level accuracy on smartphones.

RTK is known for delivering centimeter-level precision by resolving carrier phase ambiguities through real-time corrections from a local base station. In professional GNSS receivers, RTK routinely achieves 1–2 cm accuracy. However, smartphones face challenges in exploiting RTK fully. Their low-cost antennas and chipsets produce unstable carrier phase measurements, leading to frequent cycle slips and ambiguity resolution failures. As a result, RTK positioning on smartphones often degrades to float solutions with errors exceeding one meter. Additionally, RTK requires a nearby base station or a network of reference stations within a limited radius (typically 10–20 km), restricting its practical coverage for mobile users.

PPP offers precise positioning globally without the need for local reference stations by using precise satellite orbit and clock corrections from global networks. While PPP can achieve decimeter to sub-meter accuracy after a convergence period, recent advances have shortened this initialization time to seconds or minutes on smartphones, especially when fused with inertial sensors. However, PPP’s accuracy generally remains lower than RTK’s centimeter-level precision, and vertical accuracy is often less reliable. PPP’s independence from local infrastructure makes it well suited for wide-area smartphone navigation.

PPP-RTK combines PPP’s global correction approach with RTK’s integer ambiguity resolution to provide centimeter-level horizontal accuracy with faster convergence times (around 60 seconds). Tests with survey-grade receivers show PPP-RTK achieves accuracy comparable to RTK horizontally, though vertical precision is somewhat lower (decimeter level). PPP-RTK’s ability to deliver high precision without a nearby base station makes it a promising technique for smartphones, although mass-market adoption is still in early stages due to hardware and software maturity requirements.

**Cost**

DGNSS is relatively low cost for smartphone users because it leverages existing correction infrastructures and requires no specialized hardware beyond standard GNSS chipsets and access to correction data. The main costs involve data connectivity and software capable of processing raw GNSS measurements, which modern smartphones increasingly support.

RTK implementations on smartphones tend to be costly and complex. Achieving true RTK precision often requires external multi-frequency GNSS antennas and receivers, plus real-time access to local base station corrections via communication links such as NTRIP. This hardware and data requirement increases cost and reduces accessibility for typical smartphone users.

PPP is more cost-effective for smartphones since it requires only a single receiver and correction data delivered via satellite or internet, avoiding the need for local infrastructure. However, continuous data connectivity and processing capabilities are necessary, which may impact battery life and data costs.

PPP-RTK represents a middle ground with potentially lower costs than RTK because it does not require bidirectional communication with a local base station and supports broadcast-like correction delivery. Yet, the need for advanced GNSS chipsets and access to regional Continuously Operating Reference Stations (CORS) networks for optimal performance can add to costs, especially as the technology is still maturing for mass-market smartphones.

**Infrastructure Requirements**

DGNSS depends on the availability of nearby reference stations broadcasting correction data, limiting its coverage to populated or well-instrumented areas. This infrastructure dependency restricts its use in remote or rural regions.

RTK requires a dense network of local base stations or CORS within a limited radius and bidirectional communication channels to deliver corrections and receive rover data. This infrastructure is costly to maintain and limits scalability, making RTK less suitable for widespread smartphone navigation without significant network investment.

PPP operates globally without local base stations by relying on precise satellite orbit and clock corrections generated from global CORS networks and delivered via satellite or internet. This independence from local infrastructure makes PPP well suited for wide-area and remote applications, including smartphones.

PPP-RTK requires regional CORS networks similar to RTK for optimal performance but can gracefully degrade to PPP performance when outside these networks. It uses more bandwidth-efficient correction formats and one-way communication, improving scalability over RTK. However, the infrastructure to support PPP-RTK is still being developed and is less widespread than traditional RTK networks.

**Summary**

|**Technique**|**Precision on Smartphones**|**Cost**|**Infrastructure**|**Key Pros**|**Key Cons**|
| :- | :- | :- | :- | :- | :- |
|DGNSS|Meter-level (~1.75 m horizontal)|Low|Needs local reference stations|Low cost, easy to implement|Limited precision, coverage constrained|
|RTK|Centimeter-level (challenging on smartphones)|High|Local base stations, bidirectional comms|Highest precision|Hardware complexity, limited coverage, costly|
|PPP|Decimeter to sub-meter, fast convergence improving|Moderate|Global corrections via satellite/internet|Global coverage, no base stations needed|Longer convergence, lower precision than RTK|
|PPP-RTK|Centimeter-level horizontal, decimeter vertical|Moderate to high|Regional CORS, broadcast corrections|Combines RTK accuracy with PPP scalability|Emerging tech, infrastructure still developing|

**Conclusion**

<a name="ole_link7"></a>While RTK remains the gold standard for centimeter-level accuracy, its practical application on smartphones is hindered by hardware limitations and infrastructure demands. DGNSS offers a cost-effective way to improve accuracy modestly but is limited in precision and coverage. PPP provides a scalable, global solution with moderate accuracy suitable for widespread smartphone use, and PPP-RTK emerges as a promising hybrid approach combining the strengths of RTK and PPP, poised to enable high-precision smartphone navigation as hardware and infrastructure evolve.

## Task 2 – GNSS in Urban Areas

Urban areas present significant challenges to GNSS positioning due to signal blockage, multipath effects, and poor satellite visibility. In this task, you are provided with a sky mask, which indicates the elevation angle representing potential satellite visibility blockage for each corresponding azimuth angle, at the ground truth of the "Urban" environment in Assignment 1.

Your objective is to improve the GNSS positioning performance using the "Urban" data provided. The elevation of the ground truth is 3.0 m, such that the ground truth in geodetic coordinates (latitude in degrees, longitude in degrees, and altitude in meters) is (22.3198722, 114.209101777778, 3.0). You may apply any suitable methods, techniques, or algorithms to enhance accuracy.

(Hint: The sky mask can identify satellite visibility blockage by providing satellite azimuth and elevation angles.)

(1) Sky Mask Processing

The sky mask data provides elevation angle thresholds corresponding to different azimuth angles. Continuous elevation angle threshold curves are generated using cubic spline interpolation, covering all azimuth angles from 0° to 360°, with a resolution of 0.1° after interpolation.

(2) Satellite Visibility Screening

For each epoch, the azimuth and elevation of the satellites relative to the ground truth are calculated. If the satellite's elevation angle is below the corresponding sky mask threshold for its azimuth angle, it is deemed not visible and is discarded.

(3) Weighted Least Squares Positioning

Positioning is performed using only visible satellites, solving the user's position through the weighted least squares (WLS) method.

(4) Statistical Errors of Original WLS and Sky Mask Enhanced WLS Results

Run the improve\_urban\_pos\_with\_skymask0429.m code to get the following results.

|Method|East Direction (Mean / meters)|North Direction (Mean / meters)|Up Direction (Mean / meters)|
| :-: | :-: | :-: | :-: |
|Original WLS|509\.43|222\.57|1875\.27|
|Sky Mask Enhanced WLS|255\.93|111\.41|941\.62|

As can be seen from the table, using WLS to predict the user's location, due to factors such as building obstructions, there are significant errors in the ENU, especially in the Up direction, where the average error reaches 1875 meters. By incorporating sky mask data, the errors in all three ENU directions are effectively reduced, but the error values are still relatively large.

## Task 3 – GPS RAIM (Receiver Autonomous Integrity Monitoring)

RAIM is a critical technique for detecting and excluding faulty GPS measurements. In this task, you are required to:

- <a name="ole_link3"></a><a name="ole_link4"></a><a name="ole_link22"></a><a name="ole_link23"></a>Develop a classic <a name="ole_link26"></a><a name="ole_link27"></a>weighted RAIM algorithm to improve and monitor your positioning performance.
- Based on your weighted least squares (WLS) code from Assignment 1, implement a weighted RAIM algorithm to process the provided “Open-Sky” data.
- Ensure your solution effectively detects and excludes the impact of faulty or low-quality measurements.
- (Bonus) Compute the 3D protection level (PL) based on: 1). 10^-2 of probability of false alarm (P\_fa), and 2). 10^-7 of probability of missed detection (P\_md). The GPS pseudorange measurement sigma (σ) is 3m.
- (Bonus) Evaluate the GNSS integrity monitoring performance using a Stanford Chart analysis, given that the 3D alarm limit (AL) is 50 meters.

Hint 1: Calculate the only solution so that the minimum degree of freedom is 4 (meaning you can use the same equations given in the lecture notes).

Hint 2: A threshold set at 5.33 σ, the probability that random Gaussian noise causes a value to exceed that threshold is only 1 in 10 million (10^-7)

Classical Weighted RAIM (Receiver Autonomous Integrity Monitoring) is implemented based on the Weighted Least Squares (WLS) method, which iteratively optimizes the user’s position and clock bias, and detects abnormal satellite signals. The inputs include pseudorange observations (prvec), satellite coordinates (svxyzr), carrier-to-noise ratio weights (cn0), and initial position estimates (initpos). The user's latitude, longitude and height predictions are then obtained.

![](Aspose.Words.135f7995-d702-4c03-b4ee-c5b22e48d885.001.png)

![](Aspose.Words.135f7995-d702-4c03-b4ee-c5b22e48d885.002.png)

From the predicted results, the WLS-based RAIM algorithm performs well in predicting the user's accuracy and latitude. It can be seen that the predicted latitude and longitude of the user's location are almost identical to the true position, with a small error. However, there is some deviation in the predicted height. Compared to the true height of 3 meters, the average estimated height error is 2.08 meters, showing an overall good performance.

## Task 4 – LEO Satellites for Navigation

<a name="ole_link8"></a><a name="ole_link9"></a><a name="ole_link10"></a>Low Earth Orbit (LEO) satellites are widely used for communication purposes but present unique challenges when utilized for navigation. Write a short essay (500–1000 words) discussing:

- The difficulties and challenges of using LEO communication satellites for GNSS navigation.

<a name="ole_link13"></a><a name="ole_link14"></a>**Model:** Perplexity.AI

**Comment:** It helps me better clarify the concepts, find reference materials, and integrate information to complete the task.

**Chatroom Link:** https://www.perplexity.ai/search/what-are-low-earth-orbit-leo-s-DGk08HJWTrG5QsH.Q3Py1w

Low Earth Orbit (LEO) satellites have become increasingly prominent in communication systems, offering advantages such as low latency and strong signal strength due to their proximity to Earth. However, when it comes to utilizing these LEO communication satellites for Global Navigation Satellite System (GNSS) navigation, several unique challenges and difficulties arise. This essay explores these challenges and explains why LEO satellites, despite their potential, face limitations compared to traditional GNSS satellites operating in Medium Earth Orbit (MEO).

**Doppler Shifts and High Dynamics**

One of the foremost challenges in using LEO satellites for GNSS navigation is their rapid orbital velocity. LEO satellites orbit Earth approximately every 90 to 128 minutes, moving at speeds around 7.8 km/s. This rapid movement causes pronounced Doppler frequency shifts in the signals received by navigation systems. These shifts are significantly larger than those encountered with MEO GNSS satellites, complicating signal acquisition, tracking, and processing. Advanced Doppler compensation techniques and high-dynamic receivers are required to maintain signal integrity and accurate navigation observables.

**Rapidly Changing Satellite Geometry and Coverage**

Due to their low altitude and fast orbit, LEO satellites have a small coverage footprint and quickly change position relative to a ground receiver. This results in rapidly varying satellite geometry, which complicates the calculation of precise position fixes. Unlike MEO satellites that offer more stable geometry and longer visibility windows, LEO satellites necessitate large constellations-often numbering in the thousands-to ensure continuous and global coverage. Frequent handoffs between satellites are required to maintain consistent navigation, increasing system complexity and the potential for interruptions.

**Lack of Public Ephemeris and Clock Information**

Most LEO communication satellites are operated by private companies (e.g., Starlink, OneWeb, Iridium) primarily focused on broadband internet services rather than navigation. These operators typically do not disclose critical information such as precise ephemerides, clock synchronization, and signal specifications. This lack of transparency presents a significant obstacle for using LEO signals as reliable navigation sources. Without accurate satellite position and clock data, navigation receivers must rely on opportunistic or blind signal processing techniques, which are less precise and more computationally demanding

**Atmospheric Drag and Orbital Perturbations**

LEO satellites orbit within the upper atmosphere, where residual atmospheric particles cause drag that gradually alters their orbits. This drag, combined with gravitational perturbations from Earth’s no spherical shape and third-body effects (e.g., the Moon and Sun), leads to orbital decay and unpredictable trajectory changes. Continuous orbit determination and maintenance are necessary to ensure accurate positioning, but these factors increase the difficulty of maintaining precise real-time navigation solutions from LEO satellites.

**Receiver Design Complexity and Power Constraints**

GNSS receivers designed to exploit LEO satellite signals face increased complexity due to the need to handle high Doppler shifts, fast-changing satellite geometry, and diverse signal frequencies. Additionally, many LEO satellites are small or CubeSat-class platforms with limited power and processing capabilities, restricting the sophistication of onboard navigation hardware and software. This contrasts with traditional GNSS satellites, which are purpose-built for navigation with stable clocks and well-characterized signals.

**Interference and Signal Environment**

While LEO satellites can offer stronger signals due to their proximity, the dense and diverse LEO environment also raises challenges related to signal interference and jamming. The coexistence of thousands of satellites transmitting across multiple frequency bands increases the risk of signal congestion and interference. Although LEO signals can provide resilience against traditional GNSS jamming by offering alternative PNT sources, managing interference and ensuring robust signal processing remain ongoing challenges

**Opportunities and Research Advances**

Despite these challenges, recent research and technological developments show promise for leveraging LEO satellites in navigation. Techniques using carrier Doppler shift measurements from LEO constellations have demonstrated the ability to estimate position, velocity, and clock parameters with increasing accuracy. Novel algorithms, such as differential simultaneous tracking and navigation (DSTAN), and batch filters that model Doppler shifts precisely, have been developed to overcome the limitations posed by unknown ephemerides and clock errors. Simulation studies report significant improvements in outdoor positioning accuracy when combining LEO signals with traditional GNSS, especially in environments affected by GNSS jamming or multipath.

**Conclusion**

In summary, while LEO communication satellites offer attractive features such as strong signals and low latency, their use for GNSS navigation faces substantial difficulties. Rapid orbital motion causes large Doppler shifts and fast-changing satellite geometry, demanding sophisticated signal processing and large constellations for continuous coverage. The lack of publicly available ephemeris and clock data from commercial operators further complicates reliable navigation. Atmospheric drag and orbital perturbations require constant orbit maintenance, and receiver design must address high dynamics and power constraints. Despite these challenges, ongoing research and innovative algorithms are progressively unlocking the potential of LEO satellites to complement and enhance traditional GNSS navigation systems, particularly in scenarios where resilience and accuracy are critical.

## Task 5 – GNSS Remote Sensing

GNSS is not only used for positioning and navigation but also has significant applications in remote sensing. Write a short essay (500–1000 words) discussing the impact of GNSS in remote sensing. Please select one of the following topics covered in the lecture to discuss:

- GNSS Reflectometry (GNSS-R)
- GNSS Interferometric Reflectometry (GNSS-IR)
- GNSS Radio Occultation (GNSS-RO)
- Ionosphere mapping based GNSS ground station
- GNSS seismology

**Model:** Perplexity.AI

**Comment:** It helps me better clarify the concepts, find reference materials, and integrate information to complete the task.

Chatroom Link: https://www.perplexity.ai/search/can-you-explain-the-concept-of-hpOZnhXVRaKMUwCusHHJkg

GNSS Reflectometry (GNSS-R) has emerged as a transformative technique in remote sensing, leveraging signals from Global Navigation Satellite Systems (GNSS) not just for positioning and navigation but also for environmental monitoring and Earth observation. This essay discusses the impact of GNSS-R in remote sensing, highlighting its principles, applications, and significance in advancing our understanding of the Earth's surface and atmosphere.

**Principles of GNSS Reflectometry**

GNSS-R exploits the fact that navigation satellite signals, such as those from GPS, Galileo, GLONASS, and regional systems like NavIC, reflect off the Earth’s surface-oceans, land, ice, and vegetation-and can be captured by specialized receivers. Unlike traditional active radar systems, GNSS-R is a passive bistatic radar technique: the GNSS satellites serve as transmitters, and the receivers, which can be on satellites, aircraft, drones, or ground stations, collect both the direct and reflected signals.

By analyzing the reflected signals’ characteristics-such as power, delay, Doppler shift, and polarization-scientists derive geophysical properties of the reflecting surfaces. The primary data product, the Delay Doppler Map (DDM), maps the power of reflected signals as a function of time delay and frequency shift, providing information on surface roughness, moisture, wave height, and other parameters.

**Applications and Impact in Remote Sensing**

GNSS-R has a wide range of applications that have significant impacts on environmental monitoring, climate research, and disaster management:

<a name="ole_link15"></a><a name="ole_link16"></a>**(1) Oceanography:** GNSS-R measures sea surface roughness, wind speed, wave height, and sea level. Its L-band signals penetrate clouds and precipitation, enabling all-weather monitoring of ocean winds, which is critical for weather forecasting and hurricane tracking. NASA’s CYGNSS mission exemplifies this, providing high-temporal-resolution wind data in tropical cyclone regions.

**(2) Soil Moisture and Flood Monitoring**: GNSS-R detects changes in soil moisture and surface inundation by measuring variations in signal reflectivity. India’s EOS-08 satellite, launched in 2024, successfully demonstrated high-resolution soil moisture mapping and flood extent detection over diverse terrains, including the Sahara Desert and Amazon Rainforest, with resolutions better than 1 km over land.

**(3) Cryosphere Studies:** GNSS-R helps monitor ice extent, thickness, and melting by analyzing signal reflections from ice surfaces. Recent research using drone-based GNSS-R systems has enabled sea ice thickness estimation and monitoring of seasonal changes, contributing to climate change studies.

**(4) Vegetation and Land Surface Monitoring**: Variations in reflected GNSS signals correlate with vegetation water stress and land surface properties. Projects at the German Research Centre for Geosciences (GFZ) have applied GNSS-R to assess forest drought stress and wildfire susceptibility, providing valuable data for ecosystem management.

**(5) Natural Disaster Management:** GNSS-R’s ability to monitor floods, storms, and sea level changes in near real-time enhances disaster preparedness and response, supporting early warning systems and mitigation strategies.

**Advantages of GNSS Reflectometry**

GNSS-R offers several advantages that amplify its impact in remote sensing:

**(1) Passive and Cost-Effective:** It uses existing GNSS signals, eliminating the need for dedicated transmitters, which reduces system complexity, size, weight, and power requirements.

<a name="ole_link17"></a><a name="ole_link18"></a>**(2) All-Weather, Day-Night Operation:** L-band signals penetrate clouds and precipitation, enabling continuous monitoring regardless of weather or lighting conditions.

<a name="ole_link19"></a><a name="ole_link20"></a>**(3) Global Coverage and Frequent Revisits:** Multiple GNSS constellations provide continuous worldwide signal sources, allowing frequent observations from various platforms, including small satellites and the International Space Station.

**(4) Multi-Scale and Multi-Platform Flexibility:** GNSS-R can be implemented on ground stations, aircraft, drones, and satellites, offering versatile spatial scales from local to global.

**(5) Synergy with Other Sensors:** GNSS-R data can be combined with other remote sensing data to enhance spatial and temporal resolution of environmental parameters[8].

**Challenges and Future Directions**

Despite its promise, GNSS-R faces challenges such as weak reflected signal strength, multipath interference, and the complexity of signal processing to accurately retrieve geophysical parameters. Spatial resolution, while improving, remains coarser than some active remote sensing methods. Ongoing research focuses on algorithm development, artificial intelligence integration, and new satellite missions to enhance data quality and expand applications.

**Conclusion**

GNSS Reflectometry represents a paradigm shift in remote sensing by transforming navigation signals into valuable environmental data sources. Its passive, all-weather, and global capabilities enable diverse applications from ocean wind monitoring to soil moisture mapping and ice thickness estimation. Missions like NASA’s CYGNSS and India’s EOS-08 demonstrate GNSS-R’s operational viability and scientific value. As technology and algorithms advance, GNSS-R is poised to become an indispensable tool in Earth observation, climate monitoring, and disaster management, contributing significantly to our understanding and stewardship of the planet.

