Received: from mail-io0-f195.google.com ([209.85.223.195]:36286 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbcLBUox (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Dec 2016 15:44:53 -0500
Received: by mail-io0-f195.google.com with SMTP id s82so10071347ioi.3
        for <fstests@vger.kernel.org>; Fri, 02 Dec 2016 12:44:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7538941.tpP0Pki3Hl@wuerfel>
References: <1479948722-2936-1-git-send-email-deepa.kernel@gmail.com>
 <20161124104055.GD4609@eguan.usersys.redhat.com> <7538941.tpP0Pki3Hl@wuerfel>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Fri, 2 Dec 2016 12:44:52 -0800
Message-ID: <CABeXuvqmMhUWYZEOzLzq+E081PV+Rnu+XPy5RJdu8XTEpGq67w@mail.gmail.com>
Subject: Re: [PATCH] generic/390: Add tests for inode timestamp policy
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, y2038 Mailman List <y2038@lists.linaro.org>
List-ID: <fstests@vger.kernel.org>

>> > +_filesystem_timestamp_range()
>> > +{
>> > +   device=${1:-$TEST_DEV}
>> > +   case $FSTYP in
>> > +   ext4)   #dumpe2fs
>> > +           if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
>> > +                   echo "-2147483648 15032385535"
>> > +           else
>> > +                   echo "-2147483648 2147483647"
>> > +           fi
>>
>> Do ext3 and ext2 follow the same config as ext4?
>
> Those two only support the second case with 128 byte inodes, but the same
> check should work on all three.
>
> I have an overview of the limits on https://kernelnewbies.org/y2038/vfs,
> though I'd probably check all of them again, as some of them turned out
> to be wrong. In particular, identifying whether the on-disk timestamps
> are meant to be signed or unsigned can be a matter of interpretation
> and there may be a specification that disagrees with the implementation.

Right now I've only added tests for a few filesystems.
The plan is to add more filesystems later after we agree on the test.

-Deepa
