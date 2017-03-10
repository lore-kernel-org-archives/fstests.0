Received: from mail-ot0-f194.google.com ([74.125.82.194]:36856 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbdCJIun (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 03:50:43 -0500
Received: by mail-ot0-f194.google.com with SMTP id i1so9459867ota.3
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 00:50:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170310084511.GO14226@eguan.usersys.redhat.com>
References: <20170310063343.8722-1-eguan@redhat.com> <CAOQ4uxjYMz0vTxDsRaZoPmYyNuU1mjNUyZsFGw1PUontRep1Cw@mail.gmail.com>
 <20170310084511.GO14226@eguan.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 10 Mar 2017 10:50:41 +0200
Message-ID: <CAOQ4uxiXn5nFuCY16M+Qqjcjo_K4+CbZaZiSFCF=+tvf1fQt9g@mail.gmail.com>
Subject: Re: [PATCH] common/rc: use findmnt to check mounted device
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 10:45 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Fri, Mar 10, 2017 at 09:43:36AM +0200, Amir Goldstein wrote:
>> On Fri, Mar 10, 2017 at 8:33 AM, Eryu Guan <eguan@redhat.com> wrote:
>> > Doing 'grep -F "$dev on "' to find the mounted device is not
>> > always accurate, e.g.
>> >
>> >  SCRATCH_DEV=/vda6 is mounted but not on SCRATCH_MNT=/vda6/ovl-mnt - aborting
>> >  Already mounted result:
>> >  /dev/vda6 on /vda6 type xfs (rw,relatime,context=system_u:object_r:nfs_t:s0,attr2,inode64,noquota)
>> >
>> > Fix it by using findmnt command and specifying the $dev as mount
>> > source, print the result in "$dev $mnt" format. This works for local
>> > filesystems, network filesystems and overlayfs, avoids all kinds of
>> > tricky and error-prone grep pattern/regex.
>> >
>> > Also fixed the if-then-fi format in _check_mounted_on() while we're
>> > at it.
>> >
>> > Signed-off-by: Eryu Guan <eguan@redhat.com>
>> > ---
>>
>> Looks good. Also passed my kvm-xfstests -c overlay run.
>
> Thanks! Can I take it as a Reviewed-by tag?
>
Sure.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
