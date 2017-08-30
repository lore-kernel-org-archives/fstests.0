Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:56056 "EHLO
        mgwym02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdH3XxV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Aug 2017 19:53:21 -0400
Subject: Re: [PATCH] btrfs/029: fix wrong usage of name filter
References: <2a13313b-d8f5-b6fd-58cb-72e05f5925c9@jp.fujitsu.com>
 <20170830110934.GF27835@eguan.usersys.redhat.com>
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Message-ID: <80ddf7d2-043c-6228-e1d8-e6a463668080@jp.fujitsu.com>
Date: Thu, 31 Aug 2017 08:53:09 +0900
MIME-Version: 1.0
In-Reply-To: <20170830110934.GF27835@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/08/30 20:09, Eryu Guan wrote:
> On Wed, Aug 30, 2017 at 04:38:16PM +0900, Misono, Tomohiro wrote:
>> btrfs/029 uses _filter_testdirs() to filter the name of $TEST_DIR and
>> $SCRATCH_MNT directory.
>>
>> In this function, it calls both _filter_test_dir and _filter_scratch
>> concatenapted by pipe. Therefore if $TEST_DIR is a prefix of
>> $SCRATCH_MNT, this filter function gives wrong filtered name for
>> $SCRATCH_MNT and the test fails.
> 
> Sorry, I'm a bit confused, how could $TEST_DIR be a prefix of
> $SCRATCH_MNT? Won't that fail the test at setup time?

I used "/mnt" for $TEST_DIR and "/mnt_scratch" for $SCRATCH_MNT and hit
this problem because "/mnt_scratch" is filtered to "$TEST_DIR_scrach"
instead of "$SCRATCH_MNT".

I think these are valid directory names and other btrfs tests run correctly
with these names.

Thanks,
Tomohiro

