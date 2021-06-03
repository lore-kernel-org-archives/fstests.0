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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB0C47082
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Jun 2021 23:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAF86140A
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Jun 2021 23:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCXYk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:24:40 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:52515 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhFCXYk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Jun 2021 19:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622762573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/kka5MotGREXHjc7Ca48M3P2OUcotjWKZriFzYSHg8=;
        b=gSCa8vVIeJFqMTBIg17IATNPbCNdF01NiGYALeZg+5iNZHj6kHV1xJ+CKUj+qaU7PhjiQV
        2CUC5+TDdyGIJ8ldACzXQyq/OSaczi4SQk3OQdbAQ7poKMBdJjA1CNDnBjn7awZujRSMNt
        9oxi5T43dZlq2/bXC+Vv4onvTdl/44c=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2059.outbound.protection.outlook.com [104.47.8.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-HqLp-NeCObKa6Gjz01P5WQ-2; Fri, 04 Jun 2021 01:22:52 +0200
X-MC-Unique: HqLp-NeCObKa6Gjz01P5WQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kelAugW8Cv2AOnqL0wzT0d8lwrWjZje2tsVE7dJtpyPljLAY8q9UxLaWWAa8cQFKPESosOODGNUXFBDHkHuYSrlEd6fsNg6tG0/fxm0NaDI855qxUU8IGxglTN3dxWYapJzmUs88xLwUJvSS0VajAoN5IWZ1wJB+jZ9D+KOu7GCiPdwMMHfz4KjRqEcrNn0cf3gVMaaR7m0TRAhUrTbWUMGwowGFGNTwppGylo5t1r3ve/0B1DD7JPLlKPeisaFjgdjhyfjnOUrTOPOwOnSuw0cf1A8+4NEz9vxVGd7alrqI5tHlfdS2uRGqwVCvrb8at5WTFpE7fr9wAcCvcgPH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMKw4WW6ayLtPSYxeK77MKsUX4bjAxWNqHVSGns6RVQ=;
 b=jOFgctqxI/jIu6UKGgIuKqiG1ZDG1pohosudmB1DLHWTdX5vMHyYJ3ayQjKZ2+J4YtleHTDO8KoKmjDRim563MLr9lQN82NvV8njjbXjLRGMgTfSnvfAenDUULIIEAWJFFJ6xtlW8EWi5TmZz4NKq5g4JckP/XHBvMMPQC61buDZwHTAcN/f9X1TMdyE43n5/B3+y+c/Ot8QQVi/PRcQ6aXvId7rY/PdK8C9j7zayycrkX+pKfrodSkguM6A3QMpxEQ2VTJI1Qk7QvnQULaI0tYh/jxFpb7/kGiWgb8WI58oarZfrzardgIizWeWoaD9UTDAkdatFbtWC13AKyhk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM7PR04MB7015.eurprd04.prod.outlook.com (2603:10a6:20b:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 23:22:51 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 23:22:51 +0000
Subject: Re: [PATCH] fstests: add basic ftrace support
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     fstests@vger.kernel.org
References: <20210601073133.194598-1-wqu@suse.com>
 <20210601164232.GA26402@locust>
 <fe305f9d-1583-f9ea-d87e-1522b252806d@suse.com>
 <20210603162603.GF26402@locust>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <f4d956c5-1752-884e-a992-c0e0fbe1ff64@suse.com>
Date:   Fri, 4 Jun 2021 07:22:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210603162603.GF26402@locust>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:180::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Thu, 3 Jun 2021 23:22:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3979cf41-807d-4565-9c99-08d926e681b6
X-MS-TrafficTypeDiagnostic: AM7PR04MB7015:
X-Microsoft-Antispam-PRVS: <AM7PR04MB70156B0573A0AF04EB6B224FD63C9@AM7PR04MB7015.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dzln4szimYdRQCZUQFz0SdabqQ8Xn8lhwvnGU7jvU7LOyi7v7ZD7iqbIDY54jb5201mOaKsw9+k9cWZ5X03IzYN59ouWNACgMfK09i5p0z6gLI0QBcgVItiTI81RWn7q/fC6JtGs2nhrph4iMugoGJK1QpKM2El57EmURUB4x3wm7y7zSIx9Ybi+mfwl7kYyuhUzYYTWGk+eJCrOoCQf926iBaDSAJd0yPo2CjiRoRbm8LlLXU+hWbo+YpJJ1CY/4/BlR3thg+Jnuu4rKiyCwqaNF/rCeZgKevl4WKbjb3al83Y2vjjgzZQ0CHoO7RId5y84Xhyz0/twBYCpXN5L3YddVwCXFkPBOTQdmYl7VN/oL7P9qce5IWtoD1G+4vKW47WdTgk/vXJAHshAWe4Ki6dOvGr1K60UEHYM+VH1/mHP9n4IcMd6EuKi6PCpe5CImM+WE0vSqO4btbFmGFBipyvlNrlFeLZtfsWHEcZVrM7h4GUBWTxZ3tF5/fEIegUP3FSIxNnr2gt/4hzaxU4glOT9EiWgoLkcveVYeJmhlxyLZQw477g0ZhmZs/fa2chonxFPMpZKIgQtk0gA5mvXJpoJYG8nnNxqlbbqRaytu+OcjzdxGSHpdkALFyHraKHQUnTH9VbcBdKFnB8cwBZmRx/00rapeUGMDVZie24i2ArEcD7omLJ876mRML9RI6cXFC4tG/LeZ9kfCalxyn32wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(376002)(346002)(136003)(366004)(6666004)(6706004)(31696002)(4326008)(16526019)(26005)(86362001)(186003)(6916009)(2906002)(31686004)(66946007)(66556008)(66476007)(83380400001)(316002)(16576012)(6486002)(5660300002)(956004)(2616005)(38100700002)(478600001)(8936002)(36756003)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?utGhg9YAL1tJy9pppbYQ0J8+AusHIXmLe7B135EguFZRcGz+RAb6UMsGpLJb?=
 =?us-ascii?Q?VIyvq/DEC7FX0mxS+d3ZGWO5HdFX4ySsOI4ZWU4g6viRShtZb4Myu+nWF2tw?=
 =?us-ascii?Q?J2rqCvzjRSKsHFYxflmjw4Ajqz7jWNmVaIo7IeWltxH6Kk22Q26UA2mxiihn?=
 =?us-ascii?Q?RFcU6o8B7XoBLwrkxaSlbvynjF9TCNBEScPU9hRbtu4VoL92VwmrJ2z5sf0p?=
 =?us-ascii?Q?MmLIgLFq1ddOxZ8rupOGERSNBtVpjmk2jibcGzTLEPFoyPlsU6SXvAABYsl1?=
 =?us-ascii?Q?AQcOdPEL9v/RjpaM8kQdh6B8M4MUiE/PAHUAQFNezMs5PvRroh/HUtQViMPN?=
 =?us-ascii?Q?7pjzgfFlIMt0rb6DRx9xAPUOVa9gcmnlbvTlhqwTcUXUbZ5AuwqeOhcRN6Cn?=
 =?us-ascii?Q?GPCI+HdTD4ShPntopZRjEOcXGG/YA34au9uZfwraj6/0BS/ORyPMz+goiPLq?=
 =?us-ascii?Q?PfJQ7HL1KoM7G/+5eAD7raOrZVI3k9rwq+8GZaL8w2ls1D65QFGvWc31ROU9?=
 =?us-ascii?Q?5KgWm5dAsDjzPSjzJmZfZKAOuyImLLLKFPpWovuPk+8+njb0lSfdHrPscUs0?=
 =?us-ascii?Q?x4clWqWGCDbMLRdsbcPjfNVBo3YF9ztHNkwwC5eXMF7VvRqLKlVhmfJkqVNw?=
 =?us-ascii?Q?HVUhEViwiV0QGMZbEuUYReHRQZcLWCBiCZkTFJ5fvEJipopXfURf2+Oh16QM?=
 =?us-ascii?Q?UvJxrRVHILkEKNS9iJYHRN/lTFR7LdhLs58Ijg2ltDnaD+Vgq5Ew8zHStFr1?=
 =?us-ascii?Q?/6nnqzzQd6m4/eJFNvYAs4IWJPobGt1oQxWaDjbYE5clnbdKg1oYS/ndVaDs?=
 =?us-ascii?Q?6X4WXgZd+PoUawnuy3XJ7Sgnx6BScGOO0YsSXtD0M4vXDaZ6NYzTmoKMK8B6?=
 =?us-ascii?Q?LFlS8GkwjIxRY61KHQQ0wvPFnx3fpDyAOhOrvZpqIuyfSFUcxUCJZZH456ul?=
 =?us-ascii?Q?eB3v8MFsEcihj+NIXXpCjXypZJ5+FODklYbwUZjJAGXFnsvFUKMSVq6egWyr?=
 =?us-ascii?Q?/T/ogYrvbev4Gygg/2z7TLmX/NHlBsJXkGRvKYD0G7IdjgejJ9Z64Q5ZKqkJ?=
 =?us-ascii?Q?FNzev7uARCM3bW4t7s5QMXoz+CK3zuOqD7iPfTsa4Z2OeREg9+ka1VR/rf20?=
 =?us-ascii?Q?9rHCI5FQ1tfblZwJxZt3YPkzwQFTU0Y5EbzQtTs6iKd25UOAmQ/O6pgu/haO?=
 =?us-ascii?Q?pPugpdqIqaQWAv/KHcFz+unt/wq0TxinPpHGIreiEHuGkdrX7KTJYu14171t?=
 =?us-ascii?Q?odyzRK2hh9AhoJT7B2F8iR8EZuDRw6bPvdZjOImoHec1d6U1pT1lTxfVPz3S?=
 =?us-ascii?Q?h/0V2eMC3WMSXK+OgT/mwN6c?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3979cf41-807d-4565-9c99-08d926e681b6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 23:22:51.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uWjpGXGLvTfoHmWIoCHncsfvwH4bhAqKb7bdGhHrMmxwuoDKlCTn3g85bMk9BLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7015
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2021/6/4 =E4=B8=8A=E5=8D=8812:26, Darrick J. Wong wrote:
> On Wed, Jun 02, 2021 at 07:45:22AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/6/2 =E4=B8=8A=E5=8D=8812:42, Darrick J. Wong wrote:
>>> On Tue, Jun 01, 2021 at 03:31:33PM +0800, Qu Wenruo wrote:
>>>> Sometimes developers want trace dump for certain test cases.
>>>>
>>>> Normally I just add "trace-cmd" calls in "check", but it would be much
>>>
>>> Heh, so do I!
>>>
>>>> better to let fstests to support ftrace dumping.
>>>>
>>>> This patchset will add basic ftrace dumping support by:
>>>>
>>>> - Clear all buffers before running each test
>>>> - Start tracing before running each test
>>>> - End tracing after test finished
>>>> - Copy the trace to "$seqres.trace" if needed
>>>>     The condition is either:
>>>>     * $KEEP_TRACE environment is set to "yes"
>>>>     * The test case failed
>>>>
>>>> Currently we only support the main ftrace buffer, but all supporting
>>>> functions have support for ftrace instances, for later expansion.
>>>
>>> I... did not know one could /have/ separate instances.
>>
>> So did I, until I checked the code of "trace-cmd clear".
>>
>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    check         | 12 +++++++-
>>>>    common/ftrace | 82 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>>>>    common/rc     |  1 +
>>>>    3 files changed, 94 insertions(+), 1 deletion(-)
>>>>    create mode 100644 common/ftrace
>>>>
>>>> diff --git a/check b/check
>>>> index ba192042..0a09dcf9 100755
>>>> --- a/check
>>>> +++ b/check
>>>> @@ -801,7 +801,7 @@ function run_section()
>>>>    		fi
>>>>    		# really going to try and run this one
>>>> -		rm -f $seqres.out.bad
>>>> +		rm -f $seqres.out.bad $seqres.trace
>>>>    		# check if we really should run it
>>>>    		_expunge_test $seqnum
>>>> @@ -839,6 +839,10 @@ function run_section()
>>>>    		# to be reported for each test
>>>>    		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
>>>> +		# Clear previous trace and start new trace
>>>> +		_clear_trace_buffers
>>>> +		_start_trace
>>>
>>> How do you actually turn on specific tracepoints?
>>
>> Normally I use trace_printk(), thus no need to enable it manually.
>>
>>>
>>> Or is the idea here to capture trace data for each test in a separate
>>> file, and it's up to the ./check caller to set that up?
>>
>> My idea is, it should be the QA guy to set it up.
>>
>> Either using my stupid trace_printk() way, or enable those events before
>> running the test.
>>
>>>
>>>> +
>>>>    		if [ "$DUMP_OUTPUT" =3D true ]; then
>>>>    			_run_seq 2>&1 | tee $tmp.out
>>>>    			# Because $? would get tee's return code
>>>> @@ -848,6 +852,11 @@ function run_section()
>>>>    			sts=3D$?
>>>>    		fi
>>>> +		_end_trace
>>>> +		if [ "$KEEP_TRACE" =3D=3D "yes" ]; then
>>>> +			_copy_trace "$seqres.trace"
>>>> +		fi
>>>> +
>>>>    		if [ -f core ]; then
>>>>    			_dump_err_cont "[dumped core]"
>>>>    			mv core $RESULT_BASE/$seqnum.core
>>>> @@ -932,6 +941,7 @@ function run_section()
>>>>    	# make sure we record the status of the last test we ran.
>>>>    	if $err ; then
>>>> +		_copy_trace "$seqres.trace"
>>>>    		bad=3D"$bad $seqnum"
>>>>    		n_bad=3D`expr $n_bad + 1`
>>>>    		tc_status=3D"fail"
>>>> diff --git a/common/ftrace b/common/ftrace
>>>> new file mode 100644
>>>> index 00000000..36886484
>>>> --- /dev/null
>>>> +++ b/common/ftrace
>>>> @@ -0,0 +1,82 @@
>>>> +#
>>>> +# Common ftrace related functions
>>>> +#
>>>
>>> New file needs a SPDX header.
>>
>> Oh, forgot that.
>>
>>>
>>>> +
>>>> +TRACE_DIR=3D"/sys/kernel/debug/tracing"
>>>> +
>>>> +_clear_trace_buffers()
>>>> +{
>>>> +	if [ ! -d "${TRACE_DIR}" ]; then
>>>> +		return
>>>> +	fi
>>>> +
>>>> +	# Clear the main buffer
>>>> +	echo 0 > "${TRACE_DIR}/trace"
>>>
>>> If one were already running trace-cmd record, will this mess up its
>>> ability to collect trace data?
>>
>> I guess it may.
>>
>> But that shouldn't be a problem, all existing buffers are before running=
 the
>> tests, thus should be considered as noise.
>=20
> Yes, that's true for the first test run, but this clears the trace
> buffers between every test.  If you start trace-cmd and run two tests,
> isn't it possible that trace buffer content will be lost if trace-cmd
> hasn't emptied the trace buffer when _clear_trace_buffers runs?

But in that case, we should have buffer saved for each test, no need for=20
the manual trace-cmd to record.

>=20
> Alternate suggestion: Now that we know about the trace instance
> functionality, what if the test runner passed a list of tracepoints to
> ./check?  Then ./check can set up a new tracing instance for itself with
> the specified tracepoints, and we can clear the buffer before each test
> and arrange to dump the contents to the trace file while the test runs.
> That will have the added benefit of not messing with any other tracing
> tools that might be running.

Yeah, that's the planned feature for the future.

But my current objective is just to remove the need for manual trace-cmd=20
calls, so that with my trace_printk() added, I can test certain known=20
reproducer without messing the fstests code.

So far it works well for my use case.

In the future, we may utilize certain instance, like 'fstests'.

Thanks,
Qu

>=20
> --D
>=20
>>
>>>
>>>> +
>>>> +	# Clear each instance buffer
>>>> +	for i in $(ls "${TRACE_DIR}/instances"); do
>>>> +		echo 0 > "${i}/trace"
>>>> +	done
>>>> +}
>>>> +
>>>> +_start_trace()
>>>> +{
>>>> +	instance=3D$1
>>>
>>> local instance=3D"$1", please don't pollute the caller's environment.
>>
>> Oh, forgot it again...
>>
>>>
>>>> +
>>>> +	if [ ! -d "${TRACE_DIR}" ]; then
>>>> +		return
>>>> +	fi
>>>> +
>>>> +	if [ -z "${instance}" ]; then
>>>> +		echo 1 > "${TRACE_DIR}/tracing_on"
>>>> +	else
>>>> +		mkdir -p "${TRACE_DIR}/instances/${instance}"
>>>> +		echo 1 > "${TRACE_DIR}/instances/${instance}/tracing_on"
>>>> +	fi
>>>> +}
>>>> +
>>>> +_end_trace()
>>>> +{
>>>> +	instance=3D$1
>>>> +
>>>> +	if [ ! -d "${TRACE_DIR}" ]; then
>>>> +		return
>>>> +	fi
>>>> +
>>>> +	if [ -z "${instance}" ]; then
>>>> +		echo 0 > "${TRACE_DIR}/tracing_on"
>>>> +	else
>>>> +		mkdir -p "${TRACE_DIR}/instances/${instance}"
>>>
>>> Er, what's the logic here?  Ensure that the instance exist so that we
>>> can disable it?
>>
>> Oh, right, we should exit directly...
>>
>> This part is copies from _start_trace() obviously...
>>
>> Thanks,
>> Qu
>>>
>>> --D
>>>
>>>> +		echo 0 > "${TRACE_DIR}/instances/${instance}/tracing_on"
>>>> +	fi
>>>> +}
>>>> +
>>>> +_remove_empty_trace()
>>>> +{
>>>> +	file=3D"$1"
>>>> +	if [ ! -f "$file" ]; then
>>>> +		return
>>>> +	fi
>>>> +
>>>> +	if [ -z "$(head -n 15 $file | sed '/^#/d')" ]; then
>>>> +		rm $file
>>>> +	fi
>>>> +}
>>>> +
>>>> +_copy_trace()
>>>> +{
>>>> +	dest=3D"$1"
>>>> +	instance=3D"$2"
>>>> +
>>>> +	if [ ! -d "${TRACE_DIR}" ]; then
>>>> +		return
>>>> +	fi
>>>> +
>>>> +	if [ -z "${instance}" ]; then
>>>> +		cp "${TRACE_DIR}/trace" "$dest"
>>>> +	elif [ -d "${TRACE_DIR}/instances/${instance}" ]; then
>>>> +		cp "${TRACE_DIR}/instances/${instance}/trace" "$dest"
>>>> +	fi
>>>> +
>>>> +	_remove_empty_trace "$dest"
>>>> +}
>>>> diff --git a/common/rc b/common/rc
>>>> index 919028ef..f9de1517 100644
>>>> --- a/common/rc
>>>> +++ b/common/rc
>>>> @@ -3,6 +3,7 @@
>>>>    # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserv=
ed.
>>>>    . common/config
>>>> +. common/ftrace
>>>>    BC=3D$(which bc 2> /dev/null) || BC=3D
>>>> --=20
>>>> 2.31.1
>>>>
>>>
>>
>=20

