Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C2C77B61
	for <linux-fstests@archiver.kernel.org>; Sat,  8 Apr 2023 04:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDHEy0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 8 Apr 2023 00:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDHEyZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 8 Apr 2023 00:54:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EF1CA01
        for <fstests@vger.kernel.org>; Fri,  7 Apr 2023 21:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kam3+QcGmgCzKYjp3Zv0bJZjlNJomJpQ4l/f+DezKv2VjXZnGxvNf4swDNWGkO6hHEak83tVcbOBbj/XM1wGHpF45HnuWYkfmb+wtdI9JS8lgMN43i5zuY5CurF3IBj601Ts0cwNmapyF1LKLtqtnAkvV+cD+pV3jmOsKHMB2K1XNpMMjnnmGzkbXUMhIZ6fss4HZWmcfOGh/IMgIbp096a1Ts837YbvUcUhJnY9mpHGufxPwtxBGeaXCnXOI5Wq31FxDydj83pIwsGuU42Wme5qeMdyhvtKvUH8/THTUpqN3c2RyErkR/Y5GvUKwvHV2jVZsZD9uLQV0G0NsZlmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5v2ENjEKxbbs4xBDQmqgk6pCrTZDzHz9S9mDA/F0+E=;
 b=G2DDBqDgWCb65VjwndOEHBQfyR1HIehv3LMnbTM5ICABtLsJg13LH1zz4vAvQjROE3VF6DOJoeq7RBC3++5PRtAk0OYRlMdu0Znyc/YAGDcZUgyj4Gmq1wmTF97YsdiLhOhV1MZ2m/EsYgsbtKSsD55zktxPERa2nisY13U+Gn1mcsRDiK5KZXEUw1tf9y/9bvwWMG0faSg9MoqbpTXXbiQOkr43SO3JucPQ/Y1Kjdp8WZPLAVtAtJe+DDvhovXuxytZclVhmvBKoT3Xv7fgIecatxQMsuYZb/oMDMcaqruiKhhw0oHYigxAUZa6p651IQo4PY4MhIpO3721ch2vEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5v2ENjEKxbbs4xBDQmqgk6pCrTZDzHz9S9mDA/F0+E=;
 b=e8yBsRnVeEM0FfF1YoFkrTb8SryEF5N4++jk8fJePIrboS03UUJTsveeGTChJJWIotBaMPMPM+WK8ZGBdQku9dgA5DNEe82ed09nGrfmEx6JSMr+V0E/6Qjz5BeJnrLPpHCUbuPoG6Q7L4YfrXcsl6gvflKrv97gS2wJbvA0g91JE+wWQRA+lNaLyua0XbhGep4/cre+Mz3AcSv7BEu851K0roCH188OLbvxv/J0yp2ZxKplg0z/la0GCtDvr7ijs1z8+w8NAo98Exh7OEvKCjdWTfwgs6zE5DGnfgeAo4dNaa55gNxN48SvdgG6SMv6WAVsye1mmCMevjlQNvVYBQ==
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Sat, 8 Apr
 2023 04:54:21 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::47) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36 via Frontend
 Transport; Sat, 8 Apr 2023 04:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.20 via Frontend Transport; Sat, 8 Apr 2023 04:54:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 7 Apr 2023
 21:54:12 -0700
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 7 Apr 2023
 21:54:12 -0700
Message-ID: <3827aead-00ba-3ed6-7f0d-781c628b8f2a@nvidia.com>
Date:   Fri, 7 Apr 2023 21:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] fstests: add MAINTAINERS and get_maintainer.pl files
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-2-zlang@kernel.org>
 <282cbb5c-489b-2665-6512-ae5781bd0b46@nvidia.com>
 <20230406204824.xd7526whlmc6ghr4@zlang-mailbox>
 <40e95eb5-66d5-7504-968f-a29a50ea3b10@nvidia.com>
 <20230408041417.7gw34mzwaigqgsz2@zlang-mailbox>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230408041417.7gw34mzwaigqgsz2@zlang-mailbox>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|BL0PR12MB5508:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e7b192-e13a-4864-ba43-08db37ed512a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahMOWa/dB9DuCualk4SbFokUpsom/SvEvRbUc6VVbuEjmi2iIHPTpdxpLFMrXRDbcKoyn34CpW9M9yJLCBMoWP0/+eXBv4fF5SbhEDb25w5qNRw+dwJU0lX49K/SDIiKIiccutp+jnrFIHINdr3aUW8qCL3S8moovSOiRu0yW89rdSWny6bf8+j9AWaPz8Vqi3WRryQpO5OWMuDr/9gOp7n9RBZfv75GZM1r/EVK2mf1799PXhi8YvATFPEX3Y1aZmg7CUrhc/9wVAL4LSAUuNVGCcVmFMRaWEmdPCII95vSbbUD/KfMZLeuuGGx/9IKmX7asziUc2psGy/a4h/QHSPTC1MO4wBoWib68WAN/Lh8yYvDEQ/Z7uzqHxLtTs2qQXQjES/jnhbtLEwRy3AsGuhiNWNGzcPXCBctaVHTYSzw98wvTGmSt5zhlnIRWV2N05p4Cfr1/CtsWLoMhD1FG8eKOFtjX3DFdWEvkJ2PV63JhUIByZj+mOzd8rfzBUMLkI9uYRklyDI4x9/vfaXrW3dhvWlB5qhj97OmjnVtYhrplG0tT8Xsmy/ywz/hDc3qkN0Ze8Sq2126TbrFdQx74rNe+nGRXvXP3/Z24LKHzR4V4C70DBDV9XAXa9S8S+0Zbma8TplPsloZuhp79YMcp6dnHAtqnzGNioHfY8AFKmwdPYc1RhK+bMlhAqCnXBBYXhJn4nJ5CfM2WULnp2TUpWf0eBKzauUqJFFNdb+AP8VeekqO9kSpHqOKk8nVBbDR
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39850400004)(346002)(136003)(451199021)(36840700001)(46966006)(8936002)(31686004)(36756003)(8676002)(356005)(2906002)(5660300002)(86362001)(426003)(82310400005)(40480700001)(41300700001)(6916009)(7636003)(70586007)(70206006)(31696002)(4326008)(2616005)(82740400003)(83380400001)(336012)(36860700001)(47076005)(26005)(186003)(53546011)(16576012)(316002)(16526019)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 04:54:21.0651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e7b192-e13a-4864-ba43-08db37ed512a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 4/7/23 21:14, Zorro Lang wrote:
> On Thu, Apr 06, 2023 at 01:52:55PM -0700, John Hubbard wrote:
>> On 4/6/23 13:48, Zorro Lang wrote:
>> ...
>>>>> The MAINTAINERS and get_maintainer.pl are copied from linux project,
>>>>> then made some changes for fstests specially.
>>>>
>>>> Hi Zorro,
>>>>
>>>> Instead of forking 23,000+ lines of MAINTAINERS and 2600+ lines of
>>>> script into a strange tools/ location ("tools/" would then mean fstests,
>>>> and "scripts/" would mean "everything else), this upgrade really should
>>>> simply be done in place.
>>>>
>>>> I don't see much in the following patches that *truly* requires forking
>>>> these files. And if you fix them up in place, then more people will be
>>>> able to find the fstests maintainers easily, too.
>>>
>>> Hi John,
>>>
>>> Thanks for your reviewing.
>>>
>>> What's the meaning of "fix them up in place"? Do you suggest to change
>>> the location/path of the the MAINTAINERS file and get_maintainer script,
>>> or rewrite them simply and totally (from zero)?
>>>
>>
>> I meant, change MAINTAINERS and scripts/get_maintainer.pl directly, so
>> as to get the new information about fstests and maintainers. That
>> requires some effort, because you have to keep the existing functionality
>> working, but I do think it's worth the effort.
> 
> I doubt Linux project would like to accept that :)

OK, I thought this *was* targeting the kernel. Now I see that it
is for a completely separate tree, sorry for the confusion.

nevermind, then. :)

thanks,
-- 
John Hubbard
NVIDIA

