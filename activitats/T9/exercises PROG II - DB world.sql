DELIMITER $$
USE world $$

--  -----------------------------------------------------------------------------------------------------------------
--                                         Practicing CURSORS in MySQL
--  -----------------------------------------------------------------------------------------------------------------

-- 1) Create a FUNCTION with one argument (a country code) that returns a list of languages spoken in this country.
select Language from countrylanguage where CountryCode = 'ESP' $$

drop function if exists idiomes_pais $$

create function idiomes_pais (pais char(3)) returns varchar(300)
reads sql data
begin
	declare llista varchar(300) default '';
    declare idioma char(30);
	declare final boolean default false;
	declare myLanguages cursor for
		select Language from countrylanguage where CountryCode =pais;
    declare continue handler for not found set final = true;
    

    open myLanguages;
    bucle: loop
		fetch myLanguages into idioma;
		if final then
			leave bucle;
		end if;
        set llista = concat(llista, idioma, ' - ');
	end loop;
    
    close myLanguages;
    set llista = substring(llista, 1, char_length(llista)-2);
    return llista;
end $$


select idiomes_pais('ESP') $$ -- Basque, Catalan, Galecian, Spanish
select idiomes_pais('AGO') $$ -- Ambo, Chokwe, Kongo, Luchazi, Luimbe-nganguela, Luvale, Mbundu, Nyaneka-nkhumbi, Ovimbundu

-- [OPTIONAL] Are you able to get the same result with ONLY ONE SELECT?
select group_concat(Language separator ', ') from countrylanguage where CountryCode = 'ESP';



SELECT ... FROM .. WHERE CountryCode = 'ESP'$$
SELECT ... FROM .. WHERE CountryCode = 'AGO'$$

-- 2) Create a PROCEDURE with no arguments to get ALL countries and their languages. Use the same format as in the example below. HINT: use you previous function.
create procedure idiomes ()
begin
	declare pais_idiomes varchar(300);
    declare final boolean default flase;
	declare resultat text default '';
    
	declare myCursor cursor for select concat(name, ' (', idiomes_pais(code), ')') from country;
    declare continue handler for not found set final = true;
    
    open myCursor;
    bucle: loop
		fetch myCursor into pais_idiomes;
        
        if final then
			leave bucle;
		end if;
        
        set resultat = concat(resultat, pais_idiomes, '\n');
	end loop;
    
    close myCursor;
    select resultat;
end $$


CALL idiomes $$
/*
Afghanistan (Balochi, Dari, Pashto, Turkmenian, Uzbek)
Albania (Albaniana, Greek, Macedonian)
Algeria (Arabic, Berberi)
American Samoa (English, Samoan, Tongan)
Andorra (Catalan, French, Portuguese, Spanish)
Angola (Ambo, Chokwe, Kongo, Luchazi, Luimbe-nganguela, Luvale, Mbundu, Nyaneka-nkhumbi, Ovimbundu)
Anguilla (English)
Antarctica ()
Antigua and Barbuda (Creole English, English)
Argentina (Indian Languages, Italian, Spanish)
Armenia (Armenian, Azerbaijani)
idiomesAruba (Dutch, English, Papiamento, Spanish)
Australia (Arabic, Canton Chinese, English, German, Greek, Italian, Serbo-Croatian, Vietnamese)
Austria (Czech, German, Hungarian, Polish, Romanian, Serbo-Croatian, Slovene, Turkish)
Azerbaijan (Armenian, Azerbaijani, Lezgian, Russian)
Bahamas (Creole English, Creole French)
Bahrain (Arabic, English)
Bangladesh (Bengali, Chakma, Garo, Khasi, Marma, Santhali, Tripuri)
Barbados (Bajan, English)
Belarus (Belorussian, Polish, Russian, Ukrainian)
Belgium (Arabic, Dutch, French, German, Italian, Turkish)
Belize (English, Garifuna, Maya Languages, Spanish)
Benin (Adja, Aizo, Bariba, Fon, Ful, Joruba, Somba)
Bermuda (English)
Bhutan (Asami, Dzongkha, Nepali)
Bolivia (Aimará, Guaraní, Ketšua, Spanish)
Bosnia and Herzegovina (Serbo-Croatian)
Botswana (Khoekhoe, Ndebele, San, Shona, Tswana)
Bouvet Island ()
Brazil (German, Indian Languages, Italian, Japanese, Portuguese)
British Indian Ocean Territory ()
Brunei (Chinese, English, Malay, Malay-English)
Bulgaria (Bulgariana, Macedonian, Romani, Turkish)
Burkina Faso (Busansi, Dagara, Dyula, Ful, Gurma, Mossi)
Burundi (French, Kirundi, Swahili)
Cambodia (Chinese, Khmer, Tšam, Vietnamese)
Cameroon (Bamileke-bamum, Duala, Fang, Ful, Maka, Mandara, Masana, Tikar)
Canada (Chinese, Dutch, English, Eskimo Languages, French, German, Italian, Polish, Portuguese, Punjabi, Spanish, Ukrainian)
Cape Verde (Crioulo, Portuguese)
Cayman Islands (English)
Central African Republic (Banda, Gbaya, Mandjia, Mbum, Ngbaka, Sara)
Chad (Arabic, Gorane, Hadjarai, Kanem-bornu, Mayo-kebbi, Ouaddai, Sara, Tandjile)
Chile (Aimará, Araucan, Rapa nui, Spanish)
China (Chinese, Dong, Hui, Mantšu, Miao, Mongolian, Puyi, Tibetan, Tujia, Uighur, Yi, Zhuang)
Christmas Island (Chinese, English)
Cocos (Keeling) Islands (English, Malay)
Colombia (Arawakan, Caribbean, Chibcha, Creole English, Spanish)
Comoros (Comorian, Comorian-Arabic, Comorian-French, Comorian-madagassi, Comorian-Swahili)
Congo (Kongo, Mbete, Mboshi, Punu, Sango, Teke)
Congo, The Democratic Republic of the (Boa, Chokwe, Kongo, Luba, Mongo, Ngala and Bangi, Rundi, Rwanda, Teke, Zande)
Cook Islands (English, Maori)
Costa Rica (Chibcha, Chinese, Creole English, Spanish)
Côte d’Ivoire (Akan, Gur, Kru, Malinke, [South]Mande)
Croatia (Serbo-Croatian, Slovene)
Cuba (Spanish)
Cyprus (Greek, Turkish)
Czech Republic (Czech, German, Hungarian, Moravian, Polish, Romani, Silesiana, Slovak)
Denmark (Arabic, Danish, English, German, Norwegian, Swedish, Turkish)
Djibouti (Afar, Arabic, Somali)
Dominica (Creole English, Creole French)
Dominican Republic (Creole French, Spanish)
East Timor (Portuguese, Sunda)
Ecuador (Ketšua, Spanish)
Egypt (Arabic, Sinaberberi)
El Salvador (Nahua, Spanish)
Equatorial Guinea (Bubi, Fang)
Eritrea (Afar, Bilin, Hadareb, Saho, Tigre, Tigrinja)
Estonia (Belorussian, Estonian, Finnish, Russian, Ukrainian)
Ethiopia (Amhara, Gurage, Oromo, Sidamo, Somali, Tigrinja, Walaita)
Falkland Islands (English)
Faroe Islands (Danish, Faroese)
Fiji Islands (Fijian, Hindi)
Finland (Estonian, Finnish, Russian, Saame, Swedish)
France (Arabic, French, Italian, Portuguese, Spanish, Turkish)
French Guiana (Creole French, Indian Languages)
French Polynesia (Chinese, French, Tahitian)
French Southern territories ()
Gabon (Fang, Mbete, Mpongwe, Punu-sira-nzebi)
Gambia (Diola, Ful, Malinke, Soninke, Wolof)
Georgia (Abhyasi, Armenian, Azerbaijani, Georgiana, Osseetti, Russian)
Germany (German, Greek, Italian, Polish, Southern Slavic Languages, Turkish)
Ghana (Akan, Ewe, Ga-adangme, Gurma, Joruba, Mossi)
Gibraltar (Arabic, English)
Greece (Greek, Turkish)
Greenland (Danish, Greenlandic)
Grenada (Creole English)
Guadeloupe (Creole French, French)
Guam (Chamorro, English, Japanese, Korean, Philippene Languages)
Guatemala (Cakchiquel, Kekchí, Mam, Quiché, Spanish)
Guinea (Ful, Kissi, Kpelle, Loma, Malinke, Susu, Yalunka)
Guinea-Bissau (Balante, Crioulo, Ful, Malinke, Mandyako, Portuguese)
Guyana (Arawakan, Caribbean, Creole English)
Haiti (French, Haiti Creole)
Heard Island and McDonald Islands ()
Holy See (Vatican City State) (Italian)
Honduras (Creole English, Garifuna, Miskito, Spanish)
Hong Kong (Canton Chinese, Chiu chau, English, Fukien, Hakka)
Hungary (German, Hungarian, Romani, Romanian, Serbo-Croatian, Slovak)
Iceland (English, Icelandic)
India (Asami, Bengali, Gujarati, Hindi, Kannada, Malajalam, Marathi, Orija, Punjabi, Tamil, Telugu, Urdu)
Indonesia (Bali, Banja, Batakki, Bugi, Javanese, Madura, Malay, Minangkabau, Sunda)
Iran (Arabic, Azerbaijani, Bakhtyari, Balochi, Gilaki, Kurdish, Luri, Mazandarani, Persian, Turkmenian)
Iraq (Arabic, Assyrian, Azerbaijani, Kurdish, Persian)
Ireland (English, Irish)
Israel (Arabic, Hebrew, Russian)
Italy (Albaniana, French, Friuli, German, Italian, Romani, Sardinian, Slovene)
Jamaica (Creole English, Hindi)
Japan (Ainu, Chinese, English, Japanese, Korean, Philippene Languages)
Jordan (Arabic, Armenian, Circassian)
Kazakstan (German, Kazakh, Russian, Tatar, Ukrainian, Uzbek)
Kenya (Gusii, Kalenjin, Kamba, Kikuyu, Luhya, Luo, Masai, Meru, Nyika, Turkana)
Kiribati (Kiribati, Tuvalu)
Kuwait (Arabic, English)
Kyrgyzstan (Kazakh, Kirgiz, Russian, Tadzhik, Tatar, Ukrainian, Uzbek)
Laos (Lao, Lao-Soung, Mon-khmer, Thai)
Latvia (Belorussian, Latvian, Lithuanian, Polish, Russian, Ukrainian)
Lebanon (Arabic, Armenian, French)
Lesotho (English, Sotho, Zulu)
Liberia (Bassa, Gio, Grebo, Kpelle, Kru, Loma, Malinke, Mano)
Libyan Arab Jamahiriya (Arabic, Berberi)
Liechtenstein (German, Italian, Turkish)
Lithuania (Belorussian, Lithuanian, Polish, Russian, Ukrainian)
Luxembourg (French, German, Italian, Luxembourgish, Portuguese)
Macao (Canton Chinese, English, Mandarin Chinese, Portuguese)
Macedonia (Albaniana, Macedonian, Romani, Serbo-Croatian, Turkish)
Madagascar (French, Malagasy)
Malawi (Chichewa, Lomwe, Ngoni, Yao)
Malaysia (Chinese, Dusun, English, Iban, Malay, Tamil)
Maldives (Dhivehi, English)
Mali (Bambara, Ful, Senufo and Minianka, Songhai, Soninke, Tamashek)
Malta (English, Maltese)
Marshall Islands (English, Marshallese)
Martinique (Creole French, French)
Mauritania (Ful, Hassaniya, Soninke, Tukulor, Wolof, Zenaga)
Mauritius (Bhojpuri, Creole French, French, Hindi, Marathi, Tamil)
Mayotte (French, Mahoré, Malagasy)
Mexico (Mixtec, Náhuatl, Otomí, Spanish, Yucatec, Zapotec)
Micronesia, Federated States of (Kosrean, Mortlock, Pohnpei, Trukese, Wolea, Yap)
Moldova (Bulgariana, Gagauzi, Romanian, Russian, Ukrainian)
Monaco (English, French, Italian, Monegasque)
Mongolia (Bajad, Buryat, Dariganga, Dorbet, Kazakh, Mongolian)
Montserrat (English)
Morocco (Arabic, Berberi)
Mozambique (Chuabo, Lomwe, Makua, Marendje, Nyanja, Ronga, Sena, Shona, Tsonga, Tswa)
Myanmar (Burmese, Chin, Kachin, Karen, Kayah, Mon, Rakhine, Shan)
Namibia (Afrikaans, Caprivi, German, Herero, Kavango, Nama, Ovambo, San)
Nauru (Chinese, English, Kiribati, Nauru, Tuvalu)
Nepal (Bhojpuri, Hindi, Maithili, Nepali, Newari, Tamang, Tharu)
Netherlands (Arabic, Dutch, Fries, Turkish)
Netherlands Antilles (Dutch, English, Papiamento)
New Caledonia (French, Malenasian Languages, Polynesian Languages)
New Zealand (English, Maori)
Nicaragua (Creole English, Miskito, Spanish, Sumo)
Niger (Ful, Hausa, Kanuri, Songhai-zerma, Tamashek)
Nigeria (Bura, Edo, Ful, Hausa, Ibibio, Ibo, Ijo, Joruba, Kanuri, Tiv)
Niue (English, Niue)
Norfolk Island (English)
North Korea (Chinese, Korean)
Northern Mariana Islands (Carolinian, Chamorro, Chinese, English, Korean, Philippene Languages)
Norway (Danish, English, Norwegian, Saame, Swedish)
Oman (Arabic, Balochi)
Pakistan (Balochi, Brahui, Hindko, Pashto, Punjabi, Saraiki, Sindhi, Urdu)
Palau (Chinese, English, Palau, Philippene Languages)
Palestine (Arabic, Hebrew)
Panama (Arabic, Creole English, Cuna, Embera, Guaymí, Spanish)
Papua New Guinea (Malenasian Languages, Papuan Languages)
Paraguay (German, Guaraní, Portuguese, Spanish)
Peru (Aimará, Ketšua, Spanish)
Philippines (Bicol, Cebuano, Hiligaynon, Ilocano, Maguindanao, Maranao, Pampango, Pangasinan, Pilipino, Waray-waray)
Pitcairn (Pitcairnese)
Poland (Belorussian, German, Polish, Ukrainian)
Portugal (Portuguese)
Puerto Rico (English, Spanish)
Qatar (Arabic, Urdu)
Réunion (Chinese, Comorian, Creole French, Malagasy, Tamil)
Romania (German, Hungarian, Romani, Romanian, Serbo-Croatian, Ukrainian)
Russian Federation (Avarian, Bashkir, Belorussian, Chechen, Chuvash, Kazakh, Mari, Mordva, Russian, Tatar, Udmur, Ukrainian)
Rwanda (French, Rwanda)
Saint Helena (English)
Saint Kitts and Nevis (Creole English, English)
Saint Lucia (Creole French, English)
Saint Pierre and Miquelon (French)
Saint Vincent and the Grenadines (Creole English, English)
Samoa (English, Samoan, Samoan-English)
San Marino (Italian)
Sao Tome and Principe (Crioulo, French)
Saudi Arabia (Arabic)
Senegal (Diola, Ful, Malinke, Serer, Soninke, Wolof)
Seychelles (English, French, Seselwa)
Sierra Leone (Bullom-sherbro, Ful, Kono-vai, Kuranko, Limba, Mende, Temne, Yalunka)
Singapore (Chinese, Malay, Tamil)
Slovakia (Czech and Moravian, Hungarian, Romani, Slovak, Ukrainian and Russian)
Slovenia (Hungarian, Serbo-Croatian, Slovene)
Solomon Islands (Malenasian Languages, Papuan Languages, Polynesian Languages)
Somalia (Arabic, Somali)
South Africa (Afrikaans, English, Ndebele, Northsotho, Southsotho, Swazi, Tsonga, Tswana, Venda, Xhosa, Zulu)
South Georgia and the South Sandwich Islands ()
South Korea (Chinese, Korean)
Spain (Basque, Catalan, Galecian, Spanish)
Sri Lanka (Mixed Languages, Singali, Tamil)
Sudan (Arabic, Bari, Beja, Chilluk, Dinka, Fur, Lotuko, Nubian Languages, Nuer, Zande)
Suriname (Hindi, Sranantonga)
Svalbard and Jan Mayen (Norwegian, Russian)
Swaziland (Swazi, Zulu)
Sweden (Arabic, Finnish, Norwegian, Southern Slavic Languages, Spanish, Swedish)
Switzerland (French, German, Italian, Romansh)
Syria (Arabic, Kurdish)
Taiwan (Ami, Atayal, Hakka, Mandarin Chinese, Min, Paiwan)
Tajikistan (Russian, Tadzhik, Uzbek)
Tanzania (Chaga and Pare, Gogo, Ha, Haya, Hehet, Luguru, Makonde, Nyakusa, Nyamwesi, Shambala, Swahili)
Thailand (Chinese, Khmer, Kuy, Lao, Malay, Thai)
Togo (Ane, Ewe, Gurma, Kabyé, Kotokoli, Moba, Naudemba, Watyi)
Tokelau (English, Tokelau)
Tonga (English, Tongan)
Trinidad and Tobago (Creole English, English, Hindi)
Tunisia (Arabic, Arabic-French, Arabic-French-English)
Turkey (Arabic, Kurdish, Turkish)
Turkmenistan (Kazakh, Russian, Turkmenian, Uzbek)
Turks and Caicos Islands (English)
Tuvalu (English, Kiribati, Tuvalu)
Uganda (Acholi, Ganda, Gisu, Kiga, Lango, Lugbara, Nkole, Rwanda, Soga, Teso)
Ukraine (Belorussian, Bulgariana, Hungarian, Polish, Romanian, Russian, Ukrainian)
United Arab Emirates (Arabic, Hindi)
United Kingdom (English, Gaeli, Kymri)
United States (Chinese, English, French, German, Italian, Japanese, Korean, Polish, Portuguese, Spanish, Tagalog, Vietnamese)
United States Minor Outlying Islands (English)
Uruguay (Spanish)
Uzbekistan (Karakalpak, Kazakh, Russian, Tadzhik, Tatar, Uzbek)
Vanuatu (Bislama, English, French)
Venezuela (Goajiro, Spanish, Warrau)
Vietnam (Chinese, Khmer, Man, Miao, Muong, Nung, Thai, Tho, Vietnamese)
Virgin Islands, British (English)
Virgin Islands, U.S. (English, French, Spanish)
Wallis and Futuna (Futuna, Wallis)
Western Sahara (Arabic)
Yemen (Arabic, Soqutri)
Yugoslavia (Albaniana, Hungarian, Macedonian, Romani, Serbo-Croatian, Slovak)
Zambia (Bemba, Chewa, Lozi, Nsenga, Nyanja, Tongan)
Zimbabwe (English, Ndebele, Nyanja, Shona)

*/