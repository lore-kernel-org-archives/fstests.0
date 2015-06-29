Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63682 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751343AbbF2SId (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 29 Jun 2015 14:08:33 -0400
Subject: Re: [PATCH] btrfs: add a test of replace missing dev in diff raid
References: <1435296063-10695-1-git-send-email-wangyf-fnst@cn.fujitsu.com>
 <20150626222409.GA27386@huxley.DHCP.TheFacebook.com>
 <55910C42.7030707@cn.fujitsu.com>
From: Omar Sandoval <osandov@fb.com>
Message-ID: <5591893B.2020309@fb.com>
Date: Mon, 29 Jun 2015 11:06:51 -0700
MIME-Version: 1.0
In-Reply-To: <55910C42.7030707@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: wangyf <wangyf-fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 06/29/2015 02:13 AM, wangyf wrote:
> Hello, Omar:
> 
> To update some cases to support RAID5/6 is necessary.
> Like btrfs/011 btrfs/071 , and the man page of BTRFS-REPLACE,
> they all should be modified.
> 
> But equipment damage and missing device is small probability event when
> we use disks in our daily life. So it shouldn't be so important that we let
> _btrfs_get_profile_confilgs know it.
> Besides, every case tests a different direction of replace is good. e.g.
> 011 071  020 etc.
> 
> So I think to test it in a new case is better.  What is your opinion?
> 
> cheers,
> wangyf

Hi, Yanfeng,

Sorry, I think I might have been unclear. I definitely agree that the
missing case should be tested in a separate test case. However, I do
think that _btrfs_get_profile_configs should be updated so we can keep
things in one place and make sure that all profiles are thoroughly
tested. With _btrfs_get_profile_configs aware of RAID 5/6 and missing
device replacement, the new test case can just make use of that instead
of hardcoding the profiles to test. Does that sound alright?

Thanks!
-- 
Omar
