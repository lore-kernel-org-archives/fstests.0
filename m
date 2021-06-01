Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10673C47080
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 23:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7414613F5
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 23:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhFAXr1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:47:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:22055 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235034AbhFAXr1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Jun 2021 19:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622591144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DUH5zzf3iDqwDi1nmHf7MoEqZTjHMQ20UgCnIyutOY=;
        b=DqABxkJTOn+V2usFZIcnEOabKsmQFoh13iZyBTO8deV7SyoynHfK86jXr/bU30QYad7i0S
        UHTz5irO5FIltmBYKSYGYolO8uGtHaXEsPH77+nbTnPdgz4Iva06E5ciV9HMfOq7CXL+90
        GSdKjrsUXQDJ8x5kho8iSCS9oQaE0qI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-iTmEYkSiMtCSEIaHZDVElA-1; Wed, 02 Jun 2021 01:45:43 +0200
X-MC-Unique: iTmEYkSiMtCSEIaHZDVElA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLiW9evCs92J6QhWhziwJepVaP6BwHW3b0gXKKAgB7WOj3BishhEnUFfY0TuRoYZdyJZ1zzaXt82cB83rGO7JaWnWa/Y2zdlICsDTRHzj6L9hbxj+uNqkbeNiPXz+vfkr2oz9kJDMMkxEOBrrzF3dqOudxR+NG2PK48cwHykFJuUARkafwzSjToxWkAXswWC4R0MPjlFZxDSlefkmukK/axzrQL/olcszTxURoL+/VlJTcCyn6sKop8AMUpCcPltRh5JXMz9XZE8Nf7lEbp2JEUwFoNmyeivTwRsJgbkJFOWsoNar2dfk/jOLcVvJbzZWZd6V3ab0HbgPTaptVPSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1O5W1PqVS9QRJnReH5mnmM+DUVv5c+CpO2gxf3lQnc=;
 b=cssf4Nsl+y2Re8CbsUKrjRwXmCWnHQs1c04WW74EAAv+HId3jw1SdLYBpAUPKBjEz4mLPxzYt6LYIChq4K8VzgYayJE4yy/JKEhdA1MtidD17OFx3F1C/2SjjM/aJytZuyfzimw0Z7JmMXnDHbt3HPXCqFfZiBtkSeYGVWZryNqm/pimFaLkAA++ABJrMoIhuCSX477/MWWd3OWlTNjJObPGis0u0VMTyMp++5SjUW60dpqBirAB8skVJEAp4Yg8SFmi3Fut/h3M7oJ+UPD6otNLvyFRRcHLi2KXf7TASWO2kaCJg83PZFwR7UoufgRHQKDCvn/+2ljmIEdOX6NLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4904.eurprd04.prod.outlook.com (2603:10a6:20b:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 23:45:41 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 23:45:41 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     fstests@vger.kernel.org
References: <20210601073133.194598-1-wqu@suse.com>
 <20210601164232.GA26402@locust>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] fstests: add basic ftrace support
Message-ID: <fe305f9d-1583-f9ea-d87e-1522b252806d@suse.com>
Date:   Wed, 2 Jun 2021 07:45:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210601164232.GA26402@locust>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::32) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0019.namprd17.prod.outlook.com (2603:10b6:a03:1b8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 23:45:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c9a953-07ff-4550-a51e-08d925575daf
X-MS-TrafficTypeDiagnostic: AM6PR04MB4904:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4904EB0FFC442BE762DE7A99D63E9@AM6PR04MB4904.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umodwTC3iHczLo8kQ1YLLi9KeKTwtn/9u1CISgVi0W21BiIiK9DzYJDp0UeZw1IGi8yN+8t8m5ShEXu4KCGr/9wyptwFvdLFukJpyFJregQeMD1kXzUg6MhyO+gu3T+1dhzY1fFv4hW1ctCNFYmm/mJogbtnDU3lTTCBo2o7waooIIv6ojOqfQYwldTzrpHz6t1io8R72zQEm2USibcN8PcefkkEp/ui9EUCeWyxp7UsZCTj1hLIjI7Efy+rPRVo4qW03oFU0dL0udtqzitzeSnEFytsoyuxPlOaO65VxuOgt8DTrxUMHbTsshbLZaWLO0yss1uyyu78yRRZh8dLHm0co+homKfawS9N0JUHfMUo3ysqSzgG5/QrHO/KWDy+dGsa3JnXJwOCkDuTo/BPk4byf+9ya8IJLH7rircIDid/AfnhMnWU/Ezt+hX/hkgF7lzgruyZYkE1cMa6nN2Qc3QH96zBaJrZN9L63HiPkrfVu6EjwlldNSBboHh8KjXZjFIofCkk0P9CBDAU8+zARFeDlK01bNbx2FxZsyWENih42KCaPswoJnELP/qdB4HyOmwCbAv+QqelJAy/Wp+dY8//Eg/Fwndvq/byfi6oW5Og72ND+vBYNj0TFgd+TrPsXPkfhI/Jbm3R2fTNKHT1dxnoGVmBOj+PHY8fIsU15mRqI8ZBe0h5Dwo/7KJPIRvnjddVDJ1zK9lWqjz4/SfOvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(376002)(136003)(39850400004)(8936002)(66476007)(66556008)(66946007)(31686004)(4326008)(956004)(2616005)(16526019)(5660300002)(26005)(86362001)(8676002)(6486002)(2906002)(478600001)(38100700002)(36756003)(316002)(6706004)(6916009)(6666004)(31696002)(83380400001)(16576012)(186003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/WcmxSiSV9UAhEVngSvnyswSEUVaVUHBXzL9A62/Tgnu1U5q0LaH/Zu7Mtjl?=
 =?us-ascii?Q?OTLOQLsNxL32KQlXczR3LbhngyKKLBlkh0c1qvrbP5gJVHYPnu7QuIXa/3xY?=
 =?us-ascii?Q?lXs65hVc7Tg+xtIW989JczL7ZlfWNqHxLTI7i2ve488SgnZggvdcfYBp+Jfi?=
 =?us-ascii?Q?1Wuzl9d5dHXEnizDQ6XhkM7h+L9jkN6PKmv/LfWMxJJ23olDw+RL7t9MDflV?=
 =?us-ascii?Q?WF2X8ZoRZ8S0nT0IMq+xspHF4DffiYVAcHDp+pn5sOGc07p0EXfOcMS1GTE1?=
 =?us-ascii?Q?TQmvtIW6AzsOTcNs8Hrd0bcUZdBpIQT1/ZIM22960IX61z0eO1Avak7ZB0EH?=
 =?us-ascii?Q?2LAcoH4vgVxB2hLMqxzs9VHDbihkvTTkn6gay5ehvMFf6MPF6WPAcf5Q/nyq?=
 =?us-ascii?Q?cjarJwpvbv/7LaoRuVI/bHVkrY7dvTPRY8OO9pKJJWhxUQiYj10swzRA2/lL?=
 =?us-ascii?Q?InD8yGozSCbMO81bggz9L5Vc+44O9a4LOeuKkB1GR9JrcrM9dSJ1a0p0q5Fz?=
 =?us-ascii?Q?N2IHoWwbgd4N+MYncEb03XszgPe6veBrLNvwxYpDb2MgJ6I1sIT8Nzbd10mE?=
 =?us-ascii?Q?NeFTANvHdt/FRjPBVWzA9S2E7M6q39hXUteU+1JmSVnJy8TTfrx0Fw9wQe+x?=
 =?us-ascii?Q?iB43F5Gv2ebKNBEUc9QIAbOeLOSgx5cltjFa6xqJdjsyjW5Lx72FTkV3IuSH?=
 =?us-ascii?Q?+RmgiMAQlQFE9CRdeBLr4Tg31Sl6TgmzmmxJj/YRIVPxvG3JXn5Rq0CHkN3a?=
 =?us-ascii?Q?hxi4sN0YMV1L6t2QFi9NyNIAXHD32ZZx4w6OcolStvzJuqa04PxYzdo2LhXG?=
 =?us-ascii?Q?QEz023+W2fgi9vvlgwUyjwuzzg9ydtRoPmROi6GioN6iGr9BSb8y3ISjuFmR?=
 =?us-ascii?Q?Pdnru7k3oJQfuwPON8cWSeI2Yfhcc5ItI7NfKlRpi6I0D1+V+nFgZh0oZItv?=
 =?us-ascii?Q?rv0AyxgGRvfp2BbCaeEF9bWu1KswGZYLLkcsBy45ui5XY2S9tmQJyzG5es8s?=
 =?us-ascii?Q?rVTwJNzRyCC48DmrIukBRGGh7q6FBkW3TUV7PqPLottYYhvWUHwpe7hpDTCY?=
 =?us-ascii?Q?HUH14/hK2OmMtBeWIpK1k3Rf+RYuTHngjuoGXHRvY17kCXeBcFyllXKkil48?=
 =?us-ascii?Q?yo9Nsf5Fgk9qKOGmoG9Tt5WBmM3mdMirk9fHz7PtNR6hu6JeQZ7rLNgFyikZ?=
 =?us-ascii?Q?VwyXsWvbJS2ZqV/roAQ7Ir0uyxhHfueRan1MmXrDoK5rgUS4++c+IqFh52g3?=
 =?us-ascii?Q?pPgvwGeRSAo2qJl1WUd65ryTL9WcCbIJLjeltm9cQD+4FxkVx/EL4zVkVT4t?=
 =?us-ascii?Q?K5EnWUaD/ghdkw8bJLts4jrV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c9a953-07ff-4550-a51e-08d925575daf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 23:45:41.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8A4cc86o/CNfviW5jlo8LVzEAq1wvbzz3HNxMhbkmajulrtN+8DXdqsh/OHOiM8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4904
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2021/6/2 =E4=B8=8A=E5=8D=8812:42, Darrick J. Wong wrote:
> On Tue, Jun 01, 2021 at 03:31:33PM +0800, Qu Wenruo wrote:
>> Sometimes developers want trace dump for certain test cases.
>>
>> Normally I just add "trace-cmd" calls in "check", but it would be much
>=20
> Heh, so do I!
>=20
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
>=20
> I... did not know one could /have/ separate instances.

So did I, until I checked the code of "trace-cmd clear".

>=20
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   check         | 12 +++++++-
>>   common/ftrace | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   common/rc     |  1 +
>>   3 files changed, 94 insertions(+), 1 deletion(-)
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
> How do you actually turn on specific tracepoints?

Normally I use trace_printk(), thus no need to enable it manually.

>=20
> Or is the idea here to capture trace data for each test in a separate
> file, and it's up to the ./check caller to set that up?

My idea is, it should be the QA guy to set it up.

Either using my stupid trace_printk() way, or enable those events before=20
running the test.

>=20
>> +
>>   		if [ "$DUMP_OUTPUT" =3D true ]; then
>>   			_run_seq 2>&1 | tee $tmp.out
>>   			# Because $? would get tee's return code
>> @@ -848,6 +852,11 @@ function run_section()
>>   			sts=3D$?
>>   		fi
>>  =20
>> +		_end_trace
>> +		if [ "$KEEP_TRACE" =3D=3D "yes" ]; then
>> +			_copy_trace "$seqres.trace"
>> +		fi
>> +
>>   		if [ -f core ]; then
>>   			_dump_err_cont "[dumped core]"
>>   			mv core $RESULT_BASE/$seqnum.core
>> @@ -932,6 +941,7 @@ function run_section()
>>  =20
>>   	# make sure we record the status of the last test we ran.
>>   	if $err ; then
>> +		_copy_trace "$seqres.trace"
>>   		bad=3D"$bad $seqnum"
>>   		n_bad=3D`expr $n_bad + 1`
>>   		tc_status=3D"fail"
>> diff --git a/common/ftrace b/common/ftrace
>> new file mode 100644
>> index 00000000..36886484
>> --- /dev/null
>> +++ b/common/ftrace
>> @@ -0,0 +1,82 @@
>> +#
>> +# Common ftrace related functions
>> +#
>=20
> New file needs a SPDX header.

Oh, forgot that.

>=20
>> +
>> +TRACE_DIR=3D"/sys/kernel/debug/tracing"
>> +
>> +_clear_trace_buffers()
>> +{
>> +	if [ ! -d "${TRACE_DIR}" ]; then
>> +		return
>> +	fi
>> +
>> +	# Clear the main buffer
>> +	echo 0 > "${TRACE_DIR}/trace"
>=20
> If one were already running trace-cmd record, will this mess up its
> ability to collect trace data?

I guess it may.

But that shouldn't be a problem, all existing buffers are before running=20
the tests, thus should be considered as noise.

>=20
>> +
>> +	# Clear each instance buffer
>> +	for i in $(ls "${TRACE_DIR}/instances"); do
>> +		echo 0 > "${i}/trace"
>> +	done
>> +}
>> +
>> +_start_trace()
>> +{
>> +	instance=3D$1
>=20
> local instance=3D"$1", please don't pollute the caller's environment.

Oh, forgot it again...

>=20
>> +
>> +	if [ ! -d "${TRACE_DIR}" ]; then
>> +		return
>> +	fi
>> +
>> +	if [ -z "${instance}" ]; then
>> +		echo 1 > "${TRACE_DIR}/tracing_on"
>> +	else
>> +		mkdir -p "${TRACE_DIR}/instances/${instance}"
>> +		echo 1 > "${TRACE_DIR}/instances/${instance}/tracing_on"
>> +	fi
>> +}
>> +
>> +_end_trace()
>> +{
>> +	instance=3D$1
>> +
>> +	if [ ! -d "${TRACE_DIR}" ]; then
>> +		return
>> +	fi
>> +
>> +	if [ -z "${instance}" ]; then
>> +		echo 0 > "${TRACE_DIR}/tracing_on"
>> +	else
>> +		mkdir -p "${TRACE_DIR}/instances/${instance}"
>=20
> Er, what's the logic here?  Ensure that the instance exist so that we
> can disable it?

Oh, right, we should exit directly...

This part is copies from _start_trace() obviously...

Thanks,
Qu
>=20
> --D
>=20
>> +		echo 0 > "${TRACE_DIR}/instances/${instance}/tracing_on"
>> +	fi
>> +}
>> +
>> +_remove_empty_trace()
>> +{
>> +	file=3D"$1"
>> +	if [ ! -f "$file" ]; then
>> +		return
>> +	fi
>> +
>> +	if [ -z "$(head -n 15 $file | sed '/^#/d')" ]; then
>> +		rm $file
>> +	fi
>> +}
>> +
>> +_copy_trace()
>> +{
>> +	dest=3D"$1"
>> +	instance=3D"$2"
>> +
>> +	if [ ! -d "${TRACE_DIR}" ]; then
>> +		return
>> +	fi
>> +
>> +	if [ -z "${instance}" ]; then
>> +		cp "${TRACE_DIR}/trace" "$dest"
>> +	elif [ -d "${TRACE_DIR}/instances/${instance}" ]; then
>> +		cp "${TRACE_DIR}/instances/${instance}/trace" "$dest"
>> +	fi
>> +
>> +	_remove_empty_trace "$dest"
>> +}
>> diff --git a/common/rc b/common/rc
>> index 919028ef..f9de1517 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3,6 +3,7 @@
>>   # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
>>  =20
>>   . common/config
>> +. common/ftrace
>>  =20
>>   BC=3D$(which bc 2> /dev/null) || BC=3D
>>  =20
>> --=20
>> 2.31.1
>>
>=20

