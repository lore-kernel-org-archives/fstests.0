Received: from mail-ot0-f193.google.com ([74.125.82.193]:36378 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdCJHow (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 02:44:52 -0500
Received: by mail-ot0-f193.google.com with SMTP id i1so9347353ota.3
        for <fstests@vger.kernel.org>; Thu, 09 Mar 2017 23:44:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170310065734.GN14226@eguan.usersys.redhat.com>
References: <1488957991-18194-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxhq2h_WEKz1o+_AC8qFT6n6x40eUcBUpoe2eT1pfHAo7w@mail.gmail.com>
 <20170308115136.GF14226@eguan.usersys.redhat.com> <CAOQ4uxiJKouz9c=91Odd1CsrmkiKcnFuQT1r2V1Fa+UuOm9fxw@mail.gmail.com>
 <20170309095938.GJ14226@eguan.usersys.redhat.com> <CAOQ4uxhcb1UnX29nsEEvp5djaWMHXc_dO==Pibv4i2AvXmfjTA@mail.gmail.com>
 <CAOQ4uxijM=6AJjPCG23w6QWK8z4+a-5pRW2wZEXbVXJbGz=csQ@mail.gmail.com>
 <20170310035240.GK14226@eguan.usersys.redhat.com> <20170310065734.GN14226@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 10 Mar 2017 09:44:50 +0200
Message-ID: <CAOQ4uxjB_HMVsUD3XU+kFcc2CwB8P0QC52pRp+kjKShKyj1ffw@mail.gmail.com>
Subject: Re: [PATCH] generic/411: change sub-path name that's duplicate of TEST_DIR
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 8:57 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Fri, Mar 10, 2017 at 11:52:40AM +0800, Eryu Guan wrote:
[...]
>> > > Are you planning to keep my patch as is or drop the else statement in
>> > > the filters?
>>
>> I was testing your attached patch as is, if you can send a formal patch
>> with the else statement dropped that'd be great.
>
> Your test patch worked fine in my testing. I tested the following
> configs with both reflink enabled xfs (which could cover the most test
> cases) and overlayfs on top of xfs (both old and new config)
>
> # kvm-xfstests config
> TEST_DEV=/dev/sdc1
> TEST_DIR=/sdc1
> SCRATCH_DEV=/dev/sdc2
> SCRATCH_MNT=/sdc2
>
> # djwong config
> TEST_DEV=/dev/sdc1
> TEST_DIR=/mnt
> SCRATCH_DEV=/dev/sdc2
> SCRATCH_MNT=/opt
>

Cool. I sent you the formal patch without the else statement.
It passed my kvm-xfstests run with new overlay config (along with your patch)
