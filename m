Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07BC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 11:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1100163212
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 11:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhKOLV2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Nov 2021 06:21:28 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:31555 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231544AbhKOLV1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Nov 2021 06:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636975108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3I+ZA4HPKcB9JJ1lpe0ysmEUX4ZzajmJthU2etWC1vg=;
        b=G6B7i+0MWDXPKPOpg9oy5os3+/z62mBGDLtDJOeZoPdSZneZ1yc4r/s0aGnoRxaNxwJccL
        hTBaW1rejLFiwydvm8rg4mQSx37Wi1EV56FvPlayFuX8ZFckWOZZ3Vp8wfzAl0gFULHIA+
        CQrGbyKDqjueC29srxvScUzRIdBwbdQ=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-jcg4Q2xHOieJNJ347WCSEg-1;
 Mon, 15 Nov 2021 12:18:27 +0100
X-MC-Unique: jcg4Q2xHOieJNJ347WCSEg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrKf3qrK4FabZn/A7lUDLIOgudI62RYC2Kv8fqXZ4PJXew1Vx7qvrHsF4d3Ir3MMmntPtrdfBgC7tb6Xw4uVZE1Ws2HDDHQ7GzYVbUKmUF3YYs1F5wk7YUKirpLyGte/Fr45DN4TOWU6QRPlP5Qa/dfIPTxiERj3EV8a9m7fMnvdRNDCeEQpZ43ow+U0wuQuGA9YAwk38OGmvTiGX3n6QviZbtBoF9DeW13Oh+hdYF9/twuaucdzR9kHaZeMIABeesDbLO6xsJvFFIFRwZ1qhQ7+kRUrDVVLDJwbqfemnr1LsiHjluI5qdwRxuzawvNFNAWNekWKVVmuVqMMRYW07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I+ZA4HPKcB9JJ1lpe0ysmEUX4ZzajmJthU2etWC1vg=;
 b=fGfcRpA6bnMq+47Q4tH/G1Z1OGNlqjroz2A4Slv7/dC6+I8Nb3nCvl4nVGZ1wZBZFqZlPRq71aUrmG7sHJNaZsOjcyGnhaiIlZgfGp3Y+Eb9Ebz2+1RcT74GojdvYO/PJ4FXxOu5GC5msnTvaL4ldDTcUBT3wlnIyoLSKvG4ThTomqgst3bIaYNWik5SSHp8gamqEsRoYFae9T+1oTGXXqhC8xAL3nizRr7jknEuboCKtSR4gGpAS82q+zrOkeBl2cdieab0R6zE0Uc+zZl6GafVz6J1F4SOV5sHGYSxUIziQwhu6FwiCjGVGUUHwKc2SivZOXxQaI83LHbSQPVdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM9PR04MB8471.eurprd04.prod.outlook.com (2603:10a6:20b:416::22)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Mon, 15 Nov
 2021 11:18:26 +0000
Received: from AM9PR04MB8471.eurprd04.prod.outlook.com
 ([fe80::1dd6:884:8c6c:b6b3]) by AM9PR04MB8471.eurprd04.prod.outlook.com
 ([fe80::1dd6:884:8c6c:b6b3%6]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 11:18:26 +0000
To:     fstests@vger.kernel.org
From:   Radoslav Kolev <radoslav.kolev@suse.com>
Subject: read only filesystem tests
Message-ID: <e64129cb-dec9-f0bb-9a50-ede0a7b2aca6@suse.com>
Date:   Mon, 15 Nov 2021 13:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR07CA0030.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::9) To AM9PR04MB8471.eurprd04.prod.outlook.com
 (2603:10a6:20b:416::22)
MIME-Version: 1.0
Received: from localhost.localdomain (78.83.141.197) by AS8PR07CA0030.eurprd07.prod.outlook.com (2603:10a6:20b:451::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Mon, 15 Nov 2021 11:18:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12ff4fdf-9742-4f81-d3e9-08d9a829a518
X-MS-TrafficTypeDiagnostic: AM9PR04MB8780:
X-Microsoft-Antispam-PRVS: <AM9PR04MB878042ED7B4C2CCA44DF797AE0989@AM9PR04MB8780.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJLFgZJ+5eyL3dUcBaF4Ir4G6E+A/HLu8WzX0VXC89XtXfP2mjgkivpFhDcQrsjbur12fWhltVrlmwAIFjV/Ff5kXwd5NuBST3+4Sw2rfCfiD5cJCoVzDa+rHdlAU14lYQgy/UWm8wJ3sluWTo/djlAL+fSEuxLMhqmrcZdrR6krZUIyFlGLk8A1Dm3+swUSCB0c2aAvh/d+ojCmFP0UhhS3mIHUxsWDMZHSkoYURYiBqfmasTR4vERdVQXNOGadLhknlikkBG2E1uYIeZPt+069pvQzpZMKpCnMdCjmCmtRHHXuyNS2GSK0eNvUorVT4PwOUCvywXeN2UPJrIOtUIrc8buutMarJ/iB4CPHqZ75IrprfFdJtTGz8wtOhL5GaMvZXEGnJyUKSkbN7yiGeKt1ue7R6uYVnuhWhApk+3GYmQiCiT/P9RA45WFdpIrXnHIBEr3b7gRdgBGSUhiL08lTMG5zh5GCU+RNpk4IPJ95Wua4n62bGP1NAJNY1JMexgsMB0Tuuip4Ttyq51GWdt5409ed0gEHBgivcqfLFCksxELxRYg3GffltlCUklSLPn4P7337B9fMLPvJMVZHnBpiQeI89ArKbFTTgCeY2RIR7rwJxHPM09RVwqd+PZUrxDBDK6dWH7Z4+EopQfF8gieXmS8Iat/6v+Djy1yI+TaYOQG1jTfS7QOTCcnnc/z/w4CROo7LV4hTNNKmrjqjCb17zYuLCNSVE1/AhKNr1Zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(8676002)(3480700007)(316002)(44832011)(5660300002)(2906002)(6486002)(36756003)(31696002)(4744005)(6506007)(31686004)(508600001)(38100700002)(6916009)(66476007)(186003)(956004)(66946007)(86362001)(26005)(6512007)(2616005)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2JnY2hJbXJNSlhmSitSTFVVMjVibHdzVUt5cnBFQURhRm1rckpFQlJ1WHVC?=
 =?utf-8?B?TDFJb3R5TDQ1QlpzS1JNYldzUDcxZmtTRmJHTDJYZzEyZkFHeFI0ak5NQ3k0?=
 =?utf-8?B?cnkxbmlVZlpMbHpCbTgxM1hGeG9MMlgvMFp1eVR0L3A0dXJwUjJ4VzhqM2oz?=
 =?utf-8?B?bU45UW1mT2h3Q21zWGlhSVRQT3U0cDNYM3J0Nm5TVEl2aE05Qm9hS1I1RGJz?=
 =?utf-8?B?ZTBLU1dPSUZjMklibmNCVEs4UlI1YWRwL00yR1lrZXhMbmNUMFNWMVlhQWFJ?=
 =?utf-8?B?M3YxL3YvNDRpUGVwdXpKZk96ZU9rYmU3L3NMcmo0SUVwKzBUek81ZDgzL3da?=
 =?utf-8?B?dGZ0QWFWemhCTWdGWDlxODk2OUhFdngveENVQWNIdVBmREJ3ckxQdTdXQlps?=
 =?utf-8?B?KzlhYUp6RVVOSXIwZ3VBZmJCbDVrWFljTE5xakEvMkpKSmJDelA5c0Z2N3Zx?=
 =?utf-8?B?UXlWeEJ1Rm5STkVRSDNXZEdWVHRvRFJ4KzVtMUJ1a21zT004b0dXVy9aTTRh?=
 =?utf-8?B?Q1oxeGNleGhocmdMTWdwb0g0U09ncmF1RWRWbXp2emdySGFDM2JpNzlYT1RO?=
 =?utf-8?B?WFZCbmVLZi84WWxxVUVjc2hyR3VCYW9hZU1FaVpJYWZBb0wvNE5EU2JhbEs0?=
 =?utf-8?B?VC9zWWlFaDQrNXpzY1NNNXVZM2RRclA5VXpwL1EwWFdCS1JmeU44WWVSQWNm?=
 =?utf-8?B?aS9DL1dnNTRlNGtVaDZLYVBFMTY2ZXdHKy83aldxMjhhcE4weDZHUGtCWU1B?=
 =?utf-8?B?V2tHUlZBamlhUmtpdENuWHE2WFFWNXp3RXhVV3pjYjhPS3FsQkhxRXZVZUhD?=
 =?utf-8?B?bjAvNkNzSkhXQjRxVTJFTEEvakswa2M4YkxHdmpuOC93clYxQy9uSFFENW9N?=
 =?utf-8?B?eGxoT2d2YkVtWWd3bnNlWk1LSnhMQWV0MVVtVzc4czUxTm1kOU0xMjZrZjVq?=
 =?utf-8?B?bU15UkZvcnYwUE5pb0hRRDVtclE0NHMyTEVTREo3Z2hqNk5JYW93UlQ5SUNy?=
 =?utf-8?B?N1FVb0RnUWs0Q3dwOEhqQVg2TmxkbmJGRys1QnBXZjVyTEFsY0haeTdSMWNZ?=
 =?utf-8?B?L2M1Umw4WGx3eFp1OFFoYU1CMXB3UU1jbXJYMk94MWFFMjdBbEt2cmc2RmJV?=
 =?utf-8?B?bUQ5cGd6MlQyVFE2WG9TQmp3RW0xeGowRFp3eWpaY1YvQ3l6dzZUaGxuV1hJ?=
 =?utf-8?B?MTI2UVdTNDhIUmREVHVPMTlSWnU3dEFYblMzdmNDY0tYY0txL1NYVTl1NFJs?=
 =?utf-8?B?QVlPWXlXT3VWS1BXSDRnamEyOXF3VVlIS21Na1Z2U1hFQ3JqcVRXeTdPZVp4?=
 =?utf-8?B?MGlOVzlSK2M1eTBSQ2phQkgvaDBaMUNXWFhxSi9KM3h4L0Fuekgwcm5OYmVG?=
 =?utf-8?B?Tll3dCs3Z2JaSWl1NHU4RTRFVWVnVHJ5TW5lS3gwTllnTFY0ZjNEWkFPNnVq?=
 =?utf-8?B?SCsxUTN3SUNRQWgzaEhmYktFM2Qxa0FNOVZLcXFvOERHRXQ3Tk82Y3VORlhJ?=
 =?utf-8?B?YUV1dllYZlJtdTZ0eDBxVHJLZE5nU2MvbzRpeGFZam83OEtHWTlDSDMrQ0JG?=
 =?utf-8?B?ZjlpZXMxYStPazFzdmdyRHZGaG5wY3ZvZW1INGt2WVNjcWNobVdkSGg2TkhI?=
 =?utf-8?B?cDdJMmsxM1FLcVRGeWVVNmlvUG0yaGF6S3pXbzVSSEtvcGMyR0FpdVlsVGJa?=
 =?utf-8?B?MTNFaVZXWTJkWm0wU2QwbnNRUVdULzFad2EyQXJZREVvZTNuVXRUTk5sN1pu?=
 =?utf-8?B?K0w3OHRvWGc0V20vOVFmTi9nK2J6RlJDQ1g1NFZBRVlaRnUydXVLMmJQSjhZ?=
 =?utf-8?B?c29ZZjZjT0p6VnpTNTdjek9Zbmo0eldBaVk1OCtPM1BCUzkwajkzUFNuN1lZ?=
 =?utf-8?B?amhOVWpiVjhKUUkxNElaOEZSTUFLT0w4RnlXRmlXUk94Q1RoelJPZ0h1REJq?=
 =?utf-8?B?QUN3alZTN0F4NVpSRzhjaHNiZ2Q2eXhrem5yOG9LOVN1bjZITGo5bUhsd2Q0?=
 =?utf-8?B?WmU1RThtTUZYdmFHY0RQdU1mRGhIZStWMFVQYUQrZFFpd3RVVkUwZGdjZDJ1?=
 =?utf-8?B?dW9oVUZ1Z2NyVWpvVEh5bm8wR3lsMUQ2NE16bjkrV1pkWTA1UnFXUDM5cWZy?=
 =?utf-8?B?MklkQ2g2QW9PUi93NFdndjBnajFMc0tTcWgyUE0wSVBwMzFtRGN4dHI0aE8z?=
 =?utf-8?Q?3eEGGOOa3WXn2+HL2V66P4g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ff4fdf-9742-4f81-d3e9-08d9a829a518
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8471.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 11:18:26.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSn/MgAX5/t4V2hb72XKRWkKZbQoyId9J30KlWwhhVzyPL0Yp3jUU71hsdtZAF0KDJgx+Cw8c3U5r4PyCeWCGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

I am interested in read only filesystem tests, and more specifically 
squashfs. I saw that ~2 year ago there was a patch set submitted, but 
not accepted that added support for it with some feedback, that
the tests are copied and double the maintenance burden, but sadly there 
is no easy way to avoid that.

What is the current mood about read only filesystem tests and fstests?
Is this the right project to fill this need and is it worth it trying to 
address some of the problems with the old squashfs patches?

Best regards,
Radoslav

