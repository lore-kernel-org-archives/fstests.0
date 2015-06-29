Received: from cn.fujitsu.com ([59.151.112.132]:9896 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752709AbbF2JN5 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 29 Jun 2015 05:13:57 -0400
Message-ID: <55910C42.7030707@cn.fujitsu.com>
Date: Mon, 29 Jun 2015 17:13:38 +0800
From: wangyf <wangyf-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: add a test of replace missing dev in diff raid
References: <1435296063-10695-1-git-send-email-wangyf-fnst@cn.fujitsu.com> <20150626222409.GA27386@huxley.DHCP.TheFacebook.com>
In-Reply-To: <20150626222409.GA27386@huxley.DHCP.TheFacebook.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@fb.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello, Omar:

To update some cases to support RAID5/6 is necessary.
Like btrfs/011 btrfs/071 , and the man page of BTRFS-REPLACE,
they all should be modified.

But equipment damage and missing device is small probability event when
we use disks in our daily life. So it shouldn't be so important that we let
_btrfs_get_profile_confilgs know it.
Besides, every case tests a different direction of replace is good. e.g.
011 071  020 etc.

So I think to test it in a new case is better.  What is your opinion?

cheers,
wangyf


On 06/27/2015 06:24 AM, Omar Sandoval wrote:
> On Fri, Jun 26, 2015 at 01:21:03PM +0800, Wang Yanfeng wrote:
> [snip]
>> +_test "raid1"
>> +_test "raid10"
>> +_test "raid5"
>> +_test "raid6"
> Hi, Wang Yanfeng,
>
> Thanks a lot for posting this. This looks similar to the stuff in, e.g.,
> btrfs/071:
>
> 	_btrfs_get_profile_configs replace
> 	...
> 	echo "Silence is golden"
> 	for t in "${_btrfs_profile_configs[@]}"; do
> 		run_test "$t"
> 	done
>
> It'd be nice to do it the same way in this test. _btrfs_profile_configs
> would need to be updated to support RAID 5/6 and be aware of replace
> missing. I'll attach a patch, feel free to use it. Additionally, we
> could also update btrfs/011 to test RAID 5/6.
>
> Thanks,

