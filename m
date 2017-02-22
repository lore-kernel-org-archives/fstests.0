Received: from cn.fujitsu.com ([59.151.112.132]:31247 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752760AbdBVE5E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Feb 2017 23:57:04 -0500
Message-ID: <58AD1A16.10109@cn.fujitsu.com>
Date: Wed, 22 Feb 2017 12:56:54 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] shared/005,7: fix making sure debugfs sets negative i_size
 && add strict check for dd
References: <20170220023646.GG24562@eguan.usersys.redhat.com> <1487566979-6147-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170222042041.GT24562@eguan.usersys.redhat.com>
In-Reply-To: <20170222042041.GT24562@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/02/22 12:20, Eryu Guan wrote:
> On Mon, Feb 20, 2017 at 01:02:59PM +0800, Xiao Yang wrote:
>> 1) If the kernel bug has been fixed, stat command fails to get i_size
>>     and reports "Structure needs cleaning".  So we use debugfs -R "stat"
>>     instead of stat command to make sure debugfs sets negative i_size.
>>     These cases have been broken by commit 0e13e40b247a1 ("shared/005,7:
>>     make sure debugfs sets negative i_size").
>>
>> 2) shared/007 passes unexpectedly on RHEL6.8GA and RHEL6.9Beta
>>     because of invalid argument. When debugfs fails to set i_size
>>     to -512, dd with direct flag fails and reports "invalid argument".
>>     So we can add strict check.
> But you've already added the check for i_size and _notrun if debugfs
> failed to set i_size to -512, there's no chance for dd to hit EINVAL.
> And I think any error dd is hitting is acceptable, as long as test runs
> (which means i_size was set to -1/-512 successfully). So I don't think
> we need the check on dd's output. Did I miss anything?
Hi Eryu

Thanks for your comments.

xfs/134 passed unexpectedly on RHEL7.3GA because dd hits ENOSPC.  So I think
all of these cases should fail instead of pass when hitting  unexpected 
error.
Do you think whether we only check on dd's output of xfs/133,4 or 
remove  all? :-)

Best Regards,
XIao Yang
>
>
> Thanks,
> Eryu
>
>



