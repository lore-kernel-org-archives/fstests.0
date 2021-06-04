Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC97C47082
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Jun 2021 02:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A3B6140C
	for <linux-fstests@archiver.kernel.org>; Fri,  4 Jun 2021 02:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFDCrv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:47:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:37613 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFDCrv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Jun 2021 22:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622774764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYw//X2ASsp1euGeRp37MvmM3kQEErRG0+Wvn+AEd/Q=;
        b=gAgeWQJ6+p46zbcFwZ72m0Y3AckYvrjPpkhZ1x56H6iAAdr07+QLtUj0PMI6h9wGZNZrol
        9L7Vmw+8TQfUz/JbO9JpASzA1Mm4KBW877sY7NJ8jV6SWJaSBKo3eF5WoaC0s4DLXwgUGx
        1eaeHEkGrISe2XGrnn73/T+QYtlBW1U=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-aJUCVixaOwqt9PSQ1nqeiw-1; Fri, 04 Jun 2021 04:46:03 +0200
X-MC-Unique: aJUCVixaOwqt9PSQ1nqeiw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVro3qNOvF3zPldDVbYX2BUnqJkEwbWqAH3x6zxFJru5pCp/IKSTMg9DTLQk9d4P8pnQUF/ZdZLSRhtF9DEbdoysCU0cbFxyzlc9NGeZVvTy3nOpopFoGceFwySoFJVDM2dUvx5uasqa2mK6/llpqCMzvBKKy0U4zWLdGiTeOS1Hu2yCcXWILFFQIqU8ipuXyhl5Mn3JH9vTYYCxxD3HgXHuPyTpfpc1b8DgL6HzV2HcJD7zLm7ae/akQpWwoM5wGb6oW1a9CfV+7CKaQpOX86LBFXaeA/4bsVrOmUv/OIB/Bhe4Qs2CjK0nb2/FWBpL+/+OZhHx39xdGYGvobM+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqi66jZJSczTkDkV4fdJuQrcUh1Uqc1UJ5Vzia5YQIA=;
 b=XpahMDpaFIGM3pfCbPQ388qzVcjaaRl+6mqr5mo/l38RE9hQeCCoVg1XJBBU8yNsHZO+uksgswGsRD8ICJSRKhox4j1EtD2V80tH5wX+2f4l3aA93XOzeMAOYTM0kfO0mbkyBk7ADrEtDKTuU4ig8bMHQohFzbPFvVN1OQglsL+E/mZlog6n69vICpyb4rLJpPq8F3lVUbsAUrvHFRpFHF716Jx6R3kzFSXK0h6UTaf2hNQqN1IpBF7YaH1J5f/ZDZbD5Bsnm7ucuzSPEXI8lC4kPMScb3Mj1FepNALkVIAWU4pIJdsLQLHkKsBp3qYE7GONpmNQP9Mym5UOLTSlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3336.eurprd04.prod.outlook.com (2603:10a6:209:12::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.29; Fri, 4 Jun
 2021 02:46:01 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 02:46:01 +0000
To:     Dave Chinner <david@fromorbit.com>
CC:     fstests@vger.kernel.org
References: <20210603062113.133326-1-wqu@suse.com>
 <20210604023547.GA2068689@dread.disaster.area>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] fstests: add basic ftrace support
Message-ID: <af48b9a5-9f94-5b57-7115-e802faf50886@suse.com>
Date:   Fri, 4 Jun 2021 10:45:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210604023547.GA2068689@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:180::17) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:180::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Fri, 4 Jun 2021 02:45:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64582a73-17ad-4fd7-9c25-08d92702e372
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3336:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB333636F317AD4783DD136196D63B9@AM6PR0402MB3336.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inbVMZ59pIzUnwCWqujByCwjD4a+IyhChsBchRhwV5TxNSN9aKEpMFPGmUGFoHYDw3MAOmUY0AuL2nJRzBwjMd6JM1PT9QGND570Hs9lwVPLomTjmEDx1cYvFnWSOj4UWhsBKF30+UdX/agQKAYHqSMysYk60i/E3R3xAP69gKuJ6DHsHdjBfRqHSWdrRaZzq+kF1gR8t8nweHPyQtm+mX7qwWEYi94RgkQ+3miinOp6Q0Z+vN3MhMkVTCvj4wLLO4QG5wwUQByc7F3fnDszZVwX5xWrz/89V+SAKd5tSnjFcFTPSzRnwljCtwcPtadmSGU8WFrzOzJTTUcrYNGLZLAA7vEOQGGURiHYgSHfG4iJulposRfBYXzyj41Wy9szJU7WH/0JlUC4kvbhNT3aD9uAnNDyb4RykVezvX/D9siLLLnkS3DpmcL9IQUD2O/aZkMyQhS/K6cZWdm23L/bQ9GtC35v5H5XE1+Ey72sKxANQF0rpEJbNW3xQZW31qdsOVKfPTwRN4d3XWV1ripc5k3Urmwj3y3vJ/yjnG14xi6NVl80R4ZhadneDRKcN9iwr8tTa/xlr46PBkrZr9JUPO7UnvjBGQczk5nt8AtBniqqZWlRjVSm6efiBJjXPw4y5gqSrQe00DjHwHk8zXbqhGvcAQGNjNSeTeqiEcesWr3GMwyGmMlOLK2f5/0LJD3dfydpJGMhAIsOu4okht0qEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(6706004)(5660300002)(66556008)(66476007)(66946007)(186003)(38100700002)(86362001)(83380400001)(6666004)(316002)(2906002)(6486002)(478600001)(31686004)(4326008)(16576012)(8676002)(31696002)(6916009)(26005)(36756003)(16526019)(2616005)(8936002)(956004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G3BTgfaRCft0MbNs6Cr1HMvfeQe6QKUGwkH7e/bvyIXPZ5z0dMAiKVb1KRky?=
 =?us-ascii?Q?0Q4Iy4hm7Nigh05P6/oklTqPfg+phagbrrJiv88UiCU5cGX+nPTiX+cYrPzY?=
 =?us-ascii?Q?L52ddVoS6Gz3lpZ9/5etcZhPBh3gl66fhDjyzSagIXdrLRqB9ZwPqvhtue9K?=
 =?us-ascii?Q?tV575OFjQGUApqeCt8BF5Ij2uTjJEkOXr3ypxRzfpBNWxIIFG+kU+48at8eV?=
 =?us-ascii?Q?COKYCq2UfjngcR+0yUnzUEC1BRuTUyUUSIepo62q/UOdFT1SM7rSLG+TazLb?=
 =?us-ascii?Q?spm74VVG2M5gETpqx8QQu1nqLJ0L9CC1niWLF9lmuK26ypGY0dCtYNqS640e?=
 =?us-ascii?Q?x5M/l6sML6StgTrDDP7X0PMR0qs8kND6L379lNdySqkin1PR3Ey04Iyg5K1+?=
 =?us-ascii?Q?iQow5K9Dti6Yjy0vM0udFu+7c4Ca5RmSsCqHAzcAKmlDCrYFrPP4a5XwpVj7?=
 =?us-ascii?Q?vmDbbFIucncCZsOJiJ7pI0k2O7qjFNsjw3J3kFznlslvq6yPsB3QWSY1SOlO?=
 =?us-ascii?Q?2iva7dmTViDStttUhmkug3Dac9nAgHFN0O75OLpl3vgNaskbYyzcbOuJelmW?=
 =?us-ascii?Q?C0mLRGf+4s0exllEmx94xP79pTwAZfOSeKnXepoY+FVDMUYMJhzmhIgQq1Om?=
 =?us-ascii?Q?fO8xSK10Jitx7IkiX6wQLz9EWWZSyVC7Cq/fOV8sOtAVjW3tJmT808XEJskX?=
 =?us-ascii?Q?vb9Cprd8Nw9GZvR7qyAU3GxjZ/OQ6G4o5kzI2cb4kHUHCNFwtEo+rb/Wk61X?=
 =?us-ascii?Q?BwjTS7snkTUqM9itoYiJAi5P7o5ullYPl+1eCnYWBz8ozZ3lCS4UVZotLKMi?=
 =?us-ascii?Q?coyFjPVGtTTuPiHOhG4YZUhutKOrlhhpHLrZpdr/JaeoLPSeh5eJtWg1Wx3u?=
 =?us-ascii?Q?jb0oP+E1MED+ZwQXdeT8U729fXi74SOWKjOitzWVKzKWFOh25pCvp5RscRZ3?=
 =?us-ascii?Q?7kTZyguv15cNhtlsnc9tflhjJhhUljI4FHW2+WjjfB+TOh767VBC2fPB1hxH?=
 =?us-ascii?Q?4HabaybRm46PXzNSs2iVw/HUOItRBlZLPWIVVX3t6V5eKcaQ/1fGuIJahqBA?=
 =?us-ascii?Q?nnkMGhDYJhxr6kTRUj39+/bA/jrL/0DWkzyAChv/8ziib1pdrYaW7xmHbAZq?=
 =?us-ascii?Q?AoQkN8Pl+ToAo0WmKGDt2nVegdU5Yt8FRrZ4pmtUHpmogp6T3QE+kT/vBB9X?=
 =?us-ascii?Q?79XpgEKK5mLm5w4P2TFkYxWoz/UMeTIu1PPL79GxWQ7HuKwvkRVlHAT6lalH?=
 =?us-ascii?Q?GKBc9VeRyXT2DGhwh72RID6JI/kNAWNrNicQABY78dBP/Re0x/WgotrasBuN?=
 =?us-ascii?Q?dcgdoRELhGZp8HIPL0WBH2iX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64582a73-17ad-4fd7-9c25-08d92702e372
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 02:46:01.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l+J3964EW6e+XcfV3LP2wsYeqdib0Tj0a0TJjQTuzOHiuxdmEd5pxmLowAJ1HCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3336
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2021/6/4 =E4=B8=8A=E5=8D=8810:35, Dave Chinner wrote:
> On Thu, Jun 03, 2021 at 02:21:13PM +0800, Qu Wenruo wrote:
>> Sometimes developers want trace dump for certain test cases.
>>
>> Normally I just add "trace-cmd" calls in "check", but it would be much
>> better to let fstests to support ftrace dumping.
>>
>> This patchset will add basic ftrace dumping support by:
>>
>> - Clear all buffers before running each test
>> - Start tracing before running each test
>> - End tracing after test finished
>> - Copy the trace to "$seqres.trace" if needed
>>    The condition is either:
>>    * $KEEP_TRACE environment is set to "yes"
>>    * The test case failed
>>
>> Currently we only support the main ftrace buffer, but all supporting
>> functions have support for ftrace instances, for later expansion.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add explanation in "common/config" for how to use it
>> - Make variables local
>> - Don't create the instance when clearing buffers
>> ---
>>   check         | 12 +++++++-
>>   common/config |  8 +++++
>>   common/ftrace | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   common/rc     |  1 +
>>   4 files changed, 103 insertions(+), 1 deletion(-)
>>   create mode 100644 common/ftrace
>>
>> diff --git a/check b/check
>> index ba192042..0a09dcf9 100755
>> --- a/check
>> +++ b/check
>> @@ -801,7 +801,7 @@ function run_section()
>>   		fi
>>  =20
>>   		# really going to try and run this one
>> -		rm -f $seqres.out.bad
>> +		rm -f $seqres.out.bad $seqres.trace
>>  =20
>>   		# check if we really should run it
>>   		_expunge_test $seqnum
>> @@ -839,6 +839,10 @@ function run_section()
>>   		# to be reported for each test
>>   		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
>>  =20
>> +		# Clear previous trace and start new trace
>> +		_clear_trace_buffers
>> +		_start_trace
>=20
> So how does one enable all 500+ xfs tracepoints for this? Or just
> some subset? i.e. how do we pass it a list of events like we do
> trace-cmd?  IOWs, for this to be actually useful as a replacement
> for trace-cmd, it has to be able to replace invocations like this:
>=20
> # trace-cmd record -e xfs_i*lock* -e xfs_buf* -e printk -e iomap* ....

That's not a big problem, you can do the same thing just using tracefs=20
interface, without invovling trace-cmd at all.

For your above case, you can do the same thing without trace_cmd at all:

# cat ${tracefs}/available_events | grep xfs_i*lock >> \
   ${tracefs}/set_event
# cat ${tracefs}/available_events | grep xfs_buf* >> \
   ${tracefs}/set_event
# cat ${tracefs}/available_events | grep iomap* >> \
   ${tracefs}/set_event
# cat ${tracefs}/available_events | grep printk >> \
   ${tracefs}/set_event

>=20
> which is how I use trace-cmd 99.9% of the time I'm debugging fstests
> using tracepoints.

I don't bevelive above commands can be hard to use, although it's indeed=20
a little complex than trace-cmd.

>=20
> Next: some tests will generate gigabytes of trace data on XFS. I'm
> not joking here

That's exactly why I use custom trace_printk() to filter out certain=20
events, and only print what I care.

> - I regularly am looking for single traces in an
> output file that contains tens of millions of events in it. Having
> fstests run with tracing enabled is going to rapidly cause ENOSPC
> problems on test machines, and that's going to cause test harness
> issues...
>=20
> Hence I don't think that unilaterally turning on tracing is a good
> idea. I think it should only run if we set a value in the config
> section for the test run. This allows a user to define two identical
> test sections except one has "ENABLE_TRACE=3Dtrue" in it and the other
> doesn't. Hence they can run:
>=20
> # check -s xfs -g auto

And in the expected use case, trace is only used to test certain=20
failure, not to do a full test run.
It would only make things miserably slow and make your storage explode.

But we still need to clear/start/end the events for whatever test cases=20
that is going to be executed.

>=20
> to get a normal, non-traced run done. Then, for all the failures
> reported, run:
>=20
> # check -s xfs_trace <trace specification> <failed tests>
>=20
> and get those tests run with tracing enabled instead of running
>=20
> # trace-cmd record <trace specification> check -s xfs <failed tests>
>=20
> Finally, I also don't want fstests perturbing whatever tracing I'm
> doing externally to fstests, so being having it enable tracing only
> when I want it to enable tracing is somewhat important...
>=20
>> +#                   NOTE: to dump ftrace buffer one needs to enable ftr=
ace
>> +#                   events or add custom trace_printk() into the fs cod=
e.
>> +#                   And since fstest will clear buffer before running o=
ne
>> +#                   test case, existing trace-cmd can be interrupted.
>=20
> trace_printk is only a small part of the tracing I use with
> trace-cmd. If we can't configure trace event output through this
> interface, then it's really not a replacement for using trace-cmd...

I mean, if you can use trace-cmd, I see now reason you can't pack your=20
trace events into a small script to enable it before running the tests.

Or is trace-cmd really making us forget how to manually setup ftrace=20
evetnts?

Thanks,
Qu

>=20
> Cheers,
>=20
> Dave.
>=20

