Received: from cn.fujitsu.com ([59.151.112.132]:6113 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752611AbbF3Bvq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 29 Jun 2015 21:51:46 -0400
Message-ID: <5591F61F.7060009@cn.fujitsu.com>
Date: Tue, 30 Jun 2015 09:51:27 +0800
From: wangyf <wangyf-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: add a test of replace missing dev in diff raid
References: <1435296063-10695-1-git-send-email-wangyf-fnst@cn.fujitsu.com> <20150626222409.GA27386@huxley.DHCP.TheFacebook.com> <55910C42.7030707@cn.fujitsu.com> <5591893B.2020309@fb.com>
In-Reply-To: <5591893B.2020309@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@fb.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 06/30/2015 02:06 AM, Omar Sandoval wrote:
> On 06/29/2015 02:13 AM, wangyf wrote:
>> Hello, Omar:
>>
>> To update some cases to support RAID5/6 is necessary.
>> Like btrfs/011 btrfs/071 , and the man page of BTRFS-REPLACE,
>> they all should be modified.
>>
>> But equipment damage and missing device is small probability event when
>> we use disks in our daily life. So it shouldn't be so important that we let
>> _btrfs_get_profile_confilgs know it.
>> Besides, every case tests a different direction of replace is good. e.g.
>> 011 071  020 etc.
>>
>> So I think to test it in a new case is better.  What is your opinion?
>>
>> cheers,
>> wangyf
> Hi, Yanfeng,
>
> Sorry, I think I might have been unclear. I definitely agree that the
> missing case should be tested in a separate test case. However, I do
> think that _btrfs_get_profile_configs should be updated so we can keep
> things in one place and make sure that all profiles are thoroughly
> tested. With _btrfs_get_profile_configs aware of RAID 5/6 and missing
> device replacement, the new test case can just make use of that instead
> of hardcoding the profiles to test. Does that sound alright?
>
> Thanks!

Hi, Omar:
I think it again, and now I think you are right.
To let _btrfs_get_profile_confilgs be aware of replace+missing
many redundant codes can be evitable.
We can use it in a new test case to test missing device.

regards.

