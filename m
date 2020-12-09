Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F26C4361B
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E52222AAA
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Dec 2020 14:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgLIO27 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:28:59 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:56635 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgLIO26 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Dec 2020 09:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607524071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmXTdTF4suMQ+vOHXNYwsoispwTIMUSnRGoyH7QvzsY=;
        b=Yu3KE7W4/wzjAHgGtml0PBeQii6mbKo0XRVjFOoTbWBVpjFCtTqCArnVo+pcIJeoVbTjt7
        6+GvC/lpIkFNRpVFAkZp9E/CK5//3/TQudOC+FpODBXN+KI6LhFuj3QncxUwMgA9dzQ7Es
        FtfP74lqyb+47ASm6eacGhrPxeOSQp8=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-VxthcJaWNpqzolHpB7XX_w-1; Wed, 09 Dec 2020 15:27:49 +0100
X-MC-Unique: VxthcJaWNpqzolHpB7XX_w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHrNsIXpYMSzZFWSDvOpDGFmX+fybvtzuzE7o0koWa2E6g6r+yPdPYGNvyhzAjwguqevj9sL5d75sXEouyPAHklT4HxnBbalIXfOIUoVrztz9vBcB5iUnT4y4gLEG1OWjKk+JTj91UnX/pgJm/3VbyeOCLpr+NE988aRZr6t7/DhXfTA7bcUMJfQAoOZ7Y+VjrdAgr+4zyk0unH+T4XH+/jpZhASM/D97qE4zaA6B34Xw4d0nuNQY7ij7C8oA5FnuNt94PVMw8Fk5n0lge/UJ/gbO42AdIxofe+gO1YF0dqcmul7091LbbMFkqlVGYJxV/KcXdwMzPpVOKKwR8ksoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmXTdTF4suMQ+vOHXNYwsoispwTIMUSnRGoyH7QvzsY=;
 b=RoSUOBg72G4PCbfAmBljEb3t2sy4amM7hH+eMsXWLNVAgfPk1tdCS5r8iMerQOmn/E7gJtR4meVSnFcHccwOq9rloPchDed65wh45iv6doLbBcSFU7LLWBEm+dnDucAxMCsDit2xkb5fj8j7+OUozC8Q+NNca1i5u/jxQ34SBkVnuqAKZ1aAnunS0/HvNNHg8BXX9N3EZmqJnih/ZqZOrKxqDXDBaNG6vC/+PjogaUqJakyaB+Iss/s29VPDGNEOJlW4OT8VyZiAI8ZyUeGjQV43nAScTPdAVPXNZ+S7kgTNFIFSOE5LVxFt3MO1Qvx7aunYe149mitzp/yplAK8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 9 Dec
 2020 14:27:48 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::4dad:a2d3:5076:54f0]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::4dad:a2d3:5076:54f0%5]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 14:27:48 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: filter uncertain stat error output
In-Reply-To: <20201209140738.1057460-1-zlang@redhat.com>
References: <20201209140738.1057460-1-zlang@redhat.com>
Date:   Wed, 09 Dec 2020 15:27:44 +0100
Message-ID: <877dprdpgf.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:9f22:7af:4762:ffbb:b222]
X-ClientProxiedBy: LO2P265CA0497.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::22) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9f22:7af:4762:ffbb:b222) by LO2P265CA0497.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 14:27:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3a20740-408c-4fbe-5672-08d89c4e9a4a
X-MS-TrafficTypeDiagnostic: VI1PR04MB6909:
X-Microsoft-Antispam-PRVS: <VI1PR04MB6909F1BBFFB5E390E2A124BBA8CC0@VI1PR04MB6909.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: boNpf1R+Wd3z2kojlrd8wT7Lah81cpCYjewAkZiTH3WUwrQ51/GrPmkP5JWJoOy2B6SZAEHaXsqpHT7b41N6Dnwj0GFvK9Pfj6B9BCYApMHY0wi1rXESKztbYIVyO3+m5GSb9pXg3apyRzItLM4lJQ+1TbHg3m4GhU/rChRhEVjzmERTfxpcBvkrmKlSncb3SVds4b31tb1HMFmjYXQkK+MAg8jc9dgxGiv8MsNU+O59pWOrsteynFtU+r8XksPkVjvC+WGOXRQQfzy0jKE8oUKRY8R1HfdHz3V3LCYhRpXpHH41FL0QUFNOcZc0Zn9o+nENAg5X1fJOdmFHMLmPgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(66946007)(2616005)(36756003)(52116002)(4744005)(66556008)(86362001)(6496006)(8936002)(186003)(16526019)(2906002)(5660300002)(8676002)(508600001)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TmtHUjlSOHNTR3NZNTd6dHArRkVCdWo3QmRHakFEeUxvcEV3dzF3eU1GTWFH?=
 =?utf-8?B?RWxvZXJVMTNRRTd6dW5IMVlKWUpqemtkOXh4SVBqUWl6YnB6RHlyR1hjYmZI?=
 =?utf-8?B?MkRxa1NYSzZSZjl4a1VHR3YxUlpxYUoyeHpmQTV4OXY3eDdRcitCRmFEd1Mw?=
 =?utf-8?B?QjRhS1JFUFlFMmtkcWVRdWV5eDgxZFM3cFdZeVNrQWduZnZKY0c1MlpBWjMz?=
 =?utf-8?B?TzRxU21vUTJYcVJrKytOQWkvUlNZeFdtc280NjJnckgwWkJrcnN0ZGRaaHR4?=
 =?utf-8?B?YlBsTXJHNEZqN01Da3dXbWFhL3NDcWdNVm03bjl5Mzc1TnFGaHpBeFRmaE9T?=
 =?utf-8?B?bThjMFduWHRrNElIQjVoUVY0SDVSUU9TL0VvSnVCVlZyN28vSFdJYXVsYTJD?=
 =?utf-8?B?UzN5ZXBQdXk5MGR2azAzMGE3NkNwNFFybjJ2bTlJTXhyMjM1dlFkQkFhNUJy?=
 =?utf-8?B?MFdEc0ZGQVhiNjlFd1k4L2ZrYi9DVk9IdjhqU09uek15ZGJoZ2h2MUI1bVlF?=
 =?utf-8?B?dzJMUURUZklMVW9qaHdxait1b1BLMmxheUJzdk5lVTd2RHI3T3BiMFpoZGY5?=
 =?utf-8?B?TlYyZmpybUJ6WmtLS1U5LzRWb3hUUERZMndZbWhyR2t4dFBRRUdOYmc2dTFD?=
 =?utf-8?B?dTZFemVGQytSejJEZDhQM0VuQWpLZUJxcGVoaHN4Qno4WmpMWUUrdnJkMW5I?=
 =?utf-8?B?MWJ5UUp2VUxTWml6MlB5VlhRVUo2d3NhN1ZMN0pxZWdNa1JxYkFVQXZvRURT?=
 =?utf-8?B?VGNGOWtTeEp3c2w2QUh0eVUvdVhLOEZoZ3JXanNFQlFSLzNoVHdzZHJXY2Jp?=
 =?utf-8?B?QjhUckt4OG8vZytFd0NjSWpOZlNZQjdhYkpBaXVRbzFFQ2JkcjRVNm91RnBq?=
 =?utf-8?B?RWozWnVnSHFKQWkxK3cxTEYwd1QzdEdCbkVMMnIyNk5xQ2JDbTNyeEdOMEZ0?=
 =?utf-8?B?UW5peWJ5TUlQaGhSN01FS3RpNHVZY1JsaWluR2t5MFlmaU9xOUlVeE93SG1x?=
 =?utf-8?B?T1RCbDk1R0ROSzhPWGRoUkd5cmVRaTdaMEVZUHNxSWYzWFUxYlF2d09sK0hq?=
 =?utf-8?B?azNiWWhEWEtORllERUIyZXM5YWFzc280YkN4alpqUXRYVVFqVlBwanRMcElh?=
 =?utf-8?B?QU4wUFBXTVZQbGtKWjgxeE41NzJuSXk1MTZZRzdYNlp5Qm5iSGpkNFNLdE1a?=
 =?utf-8?B?WHNYeWdsOXpSZUNXdEp4THYwc0RUeGIxZE56S2NJTmVrRXVSWjMxZkVJbXR4?=
 =?utf-8?B?ZDFVUnYrZkZscURhZ0xYcmpxekF0UGtEU285SDN4YTZsckdra01FYjZjbDJT?=
 =?utf-8?B?a1FWbDVmaWFlN0pDeWlVVEs1YmhsTDV3cWs0aTZrbGFmV1NPRUM3dllXWS9x?=
 =?utf-8?Q?wJc85mdVFmLqgdD/BzcvKBuPinYLFRLg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 14:27:47.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a20740-408c-4fbe-5672-08d89c4e9a4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OA8bI02eiT8RNkr82f6uS8Lw+A8ZH+PkPf1c4jEImvmgYlaPfBw3EpnlOMWrjW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> +stat()
> +{
> +	# filter uncertain "statx/stat" error output
> +	command stat $@ 2> >(sed -e 's/statx/stat/' >&2)
> +}
> +

I think $@ be quoted like so "$@" so as to handle

    stat "a a" "b b"

properly

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

