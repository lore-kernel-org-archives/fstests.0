Received: from cn.fujitsu.com ([59.151.112.132]:63280 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752803AbdEQBKO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2017 21:10:14 -0400
Message-ID: <591BA2F1.1010208@cn.fujitsu.com>
Date: Wed, 17 May 2017 09:10:09 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] common: use _require_xfs_io_command() directly to
 check fiemap
References: <1494832679-13246-1-git-send-email-yangx.jy@cn.fujitsu.com> <CAOQ4uxjA05XO6xfG1AkpF69LkkQM-y5FrKia0pU-ztx8DaPgsw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjA05XO6xfG1AkpF69LkkQM-y5FrKia0pU-ztx8DaPgsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On 2017/05/16 16:16, Amir Goldstein wrote:
> On Mon, May 15, 2017 at 10:17 AM, Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>> We could remove _require_fiemap and _require_fiemap_attr.
>>
> We COULD remove it but why SHOULD we?
>
>
Hi Amir

Sorry for my lack of explanation, this is just a cleanup for growing 
unnecessary helper.

_require_fiemap and _require_xfs_io_command "fiemap" do the same thing, but i find that
some test cases use the former and some use the latter, i feel they shoud be unified.

Moreover, the number of helpers like this is slowly growing, but it's easy to simply use
_require_xfs_io_command directly and just specify the command we want to check.

If it is acceptable, then i will rewrite the commit message and send a v2.

Thanks,
Xiao Yang





