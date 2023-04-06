Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1AFC76196
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Apr 2023 20:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjDFUxC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Apr 2023 16:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbjDFUxB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Apr 2023 16:53:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12239171F
        for <fstests@vger.kernel.org>; Thu,  6 Apr 2023 13:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyWEbdPjtVSU7sipLYGug9Ox7vqlSE9EI5sv8gFjEvrHra5DKKiFoSQMLGKk/Vr+SzBH4LMIhEpkLZTKcTmMHTUxuTofA/P3vl0Idwn9RqxngLd0RPCCzqT614+pNDtzJmN53PSI3UNnpcG5WDixZ1VaTP6d2bA8Kh7Zt8pnVLzYJlRW7tYb3bzkzZkq59UO/ia1CLxj/iKe2dYeBQLpb/0VWNijayCqNkcZ1Bg/S2VIGeP122nnEMf5tvaQpiX/GuOIVRrmJbwGboC/Ro+ESGoKpQP3HvNocRX1bW9r+0Ekegt9mLx6c6TuJ8sNPSZWwmUVoFkaVFDRanMvqgCyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opojRPA+dTDghYDVnMfllF5p90POz+mB0eDelzD9wPY=;
 b=ErKrqxlAAbokyCgQRgKFmmeO5WI6hlWZclCgg928/cXQ2UahzBjgRw5yNoBX6bty4fQbyaQKE0aMPAVo1loB9cMnfpdW4vpC7DMu99o/dxzlgfhDc0fjK85UnqPPxpVbFHsxZ6JHnjKKcVltuakYJAQsXjAcGsY/FniXECNhUbFNsoA9KZKuUqza9g1CQ4bDxUl9CQMiQ+uIDPi0ZLHSwttvtcNcWlelz/KONW5+D7ZboUblK6Br6CEdAHUbrVlBjnNXUBrcxu2lYELWnI+K1WWpFZ49i9dFCFruyrallijsl4Ko3xdCouNwXSBNwWtmfE9Ym62fesMCSaocGLl79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opojRPA+dTDghYDVnMfllF5p90POz+mB0eDelzD9wPY=;
 b=KBG7lRz38VvY3LlypirmaNBMLhyS9fJob1swUBSnc7vac95YKku8W3+QPZIqmxH5PiETgjd6SqzC2dJzsWE7ovy5nhPCYknudyhTGkpTBAno7kxnDHITmbRchrDP86a/9e8gjEO4jsXd7OZVoR3bf+xupYvFYZZ8uCOyZoAuaMFKaAprCwsrHcMYFGyP2Yx3VWrjWJ6KrD9u699Isyt1JmAROgt7lUS1gcQeA0L+Pjwz3Xv6lISglO0lfDsvwCmay+/5TCCyd1mFdZZy1MvcCoW1m/8XCF2Biwkjbyt/74sVYgzdD7dMDDBmp0NU4VXy+0ha/2sXBzZsspGx0NgbDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 20:52:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::14c1:21d:5f45:5b49]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::14c1:21d:5f45:5b49%4]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 20:52:56 +0000
Message-ID: <40e95eb5-66d5-7504-968f-a29a50ea3b10@nvidia.com>
Date:   Thu, 6 Apr 2023 13:52:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] fstests: add MAINTAINERS and get_maintainer.pl files
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-2-zlang@kernel.org>
 <282cbb5c-489b-2665-6512-ae5781bd0b46@nvidia.com>
 <20230406204824.xd7526whlmc6ghr4@zlang-mailbox>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230406204824.xd7526whlmc6ghr4@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d50adff-b925-454a-d47e-08db36e0e636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMc5WWRkKUrP5ww8skL1Abb18VN0+HYo9/gyBgvcNWZ9tcCo043LOsdOK/AIAMjefTQueB4W+J40UUy7V+qUjD6a5n9Ji50852i/OSkQrj3ECqfLn8QunSauL4NVdEa85uLv0TYA1S0F7/eYXuCUbl3iWVNqR7e1x09/O7+R8DcMAp7OZ28/7e4t77Jac8cHn6LPMlj1g1mFNNrYUxyLEineTuVZavOlqs9BpJEB9YjQS948Q1L9G++Z596iZCmOmnj1xY2diY/IkgkIs3DyR5wB1Ijhy3PU9Fwl185Gx/P+/1tSL0GfNGInjpeqjpMJeRgAR8pBJ+WkzVOH1newKWLoTgBD+KgKBg2xHYLGgF6kworBNCetQq/fm62jcrWmnf8Ee4lUkKr22wkiCymmwR0HX+xJUHPsNPszjcVjf8yKpasBxRbreJHGYHZIUucbuJh1BBqEnLBR72MKnVM7HgIl2VN6b+RE58bqfmHs/s4fgHE+t+bf66ksast3bQbFaVa9RCK0KGjBb6fcdYvKDFMcfxzR/lM0wuRV/Cx0M+bLtXMIjvAy+CFdl9krkI3kU87fPgH9AuB1EVa2MZ1CteTyqh+wdBaR6e6mJyMYbcn3rlysMU+dAJCpozzGy+s1qdoUYtBwS5wtz+RF3VDWAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(6916009)(66476007)(66946007)(8676002)(4326008)(316002)(8936002)(5660300002)(38100700002)(41300700001)(66556008)(83380400001)(186003)(53546011)(6486002)(2616005)(6506007)(26005)(6512007)(36756003)(86362001)(31696002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VUL0hkQ3Q2NmtxZ1BxQ2ZNQldBOTlweWkyVG5yZHRkU3hyMmpJTDh0N1p4?=
 =?utf-8?B?aVVSZkZkQWloc3M3a1R1NDBDcWJsTDAxemVOMWt3VDM3R01sSCtJKzFmTFJ6?=
 =?utf-8?B?bjF6VmhHT0x0OGlUNHJRT2Vwa0poQjVDVzdhRWhBa3RnQ0JYaEJtUHJqV3dq?=
 =?utf-8?B?WjRDSjFYS1g3TUEycnE4RW1XbkRySm1ZZ05FZStYT29SK1VCeUljVWNTZTRl?=
 =?utf-8?B?VlVxSE5mL1R6YlhxUnVlMWFpQ0NjMmpYeEdQNHFjSHJhNTlvU0pxZThSeHVH?=
 =?utf-8?B?Z2x3RWtWUVVlUXcyc1dheTd5ZklJbldyNjJlWjhncjdvTkFYY2k1QmRoOVE2?=
 =?utf-8?B?eSswY3M3ZnhmNU5OS1RLc3pPVGZialhJRHg5SG45OVR6Nm5DSFJaeFV1Ynpp?=
 =?utf-8?B?YWgyL21ycGE4SmgyRXg3Q2FKSEQ4WVArRUhzUm1wTCtJbWRrQ3ROekhiLzFi?=
 =?utf-8?B?d01ZMHA0ekU1Rmx1a2hmYWpVdloyMUhMRVdDU0toODEvNktXckYrVXJycGVI?=
 =?utf-8?B?MktxVGorTGIyQVlBdVM4V3c0TWVlNTJVZDJ1a1JwbGhiV3NYYzR2MWU5UG9O?=
 =?utf-8?B?OGtqWllkUDNPY014cUQrZ0lBLzZiU0RyVUtmMEErSWRibWJGcHRzRXVQQktL?=
 =?utf-8?B?dEx6RzhlSi9zRlgzbVdmc1hqZjM3YnlxRjRpWmt2YVJaOVYxcmtQMWdLMGxJ?=
 =?utf-8?B?TUY3RUJCd1p2ZXdQK0xmWUxvVnpyL21DbUx6NFFQR3pzOXZ3N3FHaitQU0tK?=
 =?utf-8?B?RWF4bDJQNlZlazM4NUtOOENxRFordEdwb3VRbm9CU1QvWTQvbVlFamZRZ0Mr?=
 =?utf-8?B?SkRITk4vblhqY1hSWUU3VEV1eVg2ZVB2MHdBWGFGdlVZdVJXWGVoYytzam9o?=
 =?utf-8?B?QWFNbmFmUnhWZUpkSFp0NnNTMko5ZG9lSWZPT1drK3F0VVJsNFlNaVFVS3JQ?=
 =?utf-8?B?anB5SkFPYmZnUm5oOHZkK2F4N3UvMS9OTE1BY1ZiZ1Q3aWdmZHMrazBleWdt?=
 =?utf-8?B?MDV1Zlk0WkErN3dkeGgzaFdqOUFCTkszK3pFTFFpbTZrbldYdTYrcmZrSDZX?=
 =?utf-8?B?RkVYLzAzZFZiUTFYYjFGcG9LUEFsakxObzgvaHUxaHpaSkFBSkt4bGl6RnRM?=
 =?utf-8?B?RWpBcE5yeVNqOVlpRW9TRTY5VlRuRlRPVE5Cb1A2UHB2dUxRSGxQb1hhdEEx?=
 =?utf-8?B?YnRUN0FjeFB2cFBBSmM1V3FRMW9yVjhxL2xKSUxzbkt3NXA3SnVmQWFSTzU0?=
 =?utf-8?B?bWJINWRnTUpuOWQ0bWg1UW9HRjZkeFYxN01iZm9DbHExMXhibWFWZFVQV043?=
 =?utf-8?B?VnRMeWpoNWZKSklDa3VXbkNRYWY4R3ZacWVtWU1XaHZodVZMN0NvWkxCYTU5?=
 =?utf-8?B?dG5VWndSV0tPTmVTSWIzMHdzQ052bU5CWVJTTzBMQlRuOWRkTFRqOU5teHA1?=
 =?utf-8?B?ZEpwZ21tU1NsRmhIVHo3cWErVkpzdWF0Wm9GTDh1Y2xDWmlUQVVrdWZSd1dD?=
 =?utf-8?B?bnh0cmRBcXM1QzVGNlljWG1GQ200MXBMd2hYcElRdEpMZFQzWkhrQjFHdEtp?=
 =?utf-8?B?d1M4aGdtSUpRcithMDkxYytDU0o0S1R3OEhyM3ZFV1h2UXpZbSs4N1ZJLzA1?=
 =?utf-8?B?VGNDUVMwODdwYTJjUFFGdkFTTDJ6YjErMjFqUzUvRTNqY2VuOXA4SmF1WWor?=
 =?utf-8?B?QURtU1pIQ3UwVXJrZFBacXpPTWtPNUhnc1RDSExCaUdkbCtNNFdMUG1DTjRL?=
 =?utf-8?B?YkhDaW9vOHBMeHBjKytnaU1FZlBsTW9yOHJKQko3TklzMmMvNStZVm5zcFQx?=
 =?utf-8?B?VldUMEVoSTA4YWpiMVJDRFFNeWhtcmVqNVZZejVGcUpIYVRyNlQ0b0NDV1hN?=
 =?utf-8?B?M01Vb3FFclZxVUM4ZWVDZTlXUEpUT0pOb2JXQnk0V0F2U2lCekZpRXRZeURW?=
 =?utf-8?B?YkVzRUpJZEVqQXlGRmZkR3I4ZHZUMU1YMlh1N2UyL1IyQVh5WC9Zdy9wNnVm?=
 =?utf-8?B?UkdkajREc0RoNHRVUXBicm10RDhPS1pCd0dCcmNzSFcvTjVtRStvTXBaVk1N?=
 =?utf-8?B?TUZ6VFVKMWRUQ2NiVFcvcmNmd0NpZytUSHhiNVFyL2VtdWw0NEg2ZjUwUDFm?=
 =?utf-8?Q?M8UZn6N8Sfi0njcboYkek03Px?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d50adff-b925-454a-d47e-08db36e0e636
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 20:52:56.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYZTBn+PIou++dibD+7FWJR+WUuh7jR2wfR/J3teLdceTLn5TDvn5HnB055XC2xNZaAj/E1WqzbX0MzI64J+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 4/6/23 13:48, Zorro Lang wrote:
...
>>> The MAINTAINERS and get_maintainer.pl are copied from linux project,
>>> then made some changes for fstests specially.
>>
>> Hi Zorro,
>>
>> Instead of forking 23,000+ lines of MAINTAINERS and 2600+ lines of
>> script into a strange tools/ location ("tools/" would then mean fstests,
>> and "scripts/" would mean "everything else), this upgrade really should
>> simply be done in place.
>>
>> I don't see much in the following patches that *truly* requires forking
>> these files. And if you fix them up in place, then more people will be
>> able to find the fstests maintainers easily, too.
> 
> Hi John,
> 
> Thanks for your reviewing.
> 
> What's the meaning of "fix them up in place"? Do you suggest to change
> the location/path of the the MAINTAINERS file and get_maintainer script,
> or rewrite them simply and totally (from zero)?
> 

I meant, change MAINTAINERS and scripts/get_maintainer.pl directly, so
as to get the new information about fstests and maintainers. That 
requires some effort, because you have to keep the existing functionality
working, but I do think it's worth the effort. 

thanks,
-- 
John Hubbard
NVIDIA
