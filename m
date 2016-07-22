Received: from mail-io0-f178.google.com ([209.85.223.178]:35957 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbcGVNIo convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 22 Jul 2016 09:08:44 -0400
Received: by mail-io0-f178.google.com with SMTP id b62so104391336iod.3
        for <fstests@vger.kernel.org>; Fri, 22 Jul 2016 06:08:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160721224057.GD12670@dastard>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
 <1468500214-6237-7-git-send-email-jtulak@redhat.com> <20160716093358.GL2432@eguan.usersys.redhat.com>
 <20160717233003.GX1922@dastard> <CACj3i73TdnUcDT0J2QEBKQhoMsyYFVz6hBb_=bC99rL2ZbkCYQ@mail.gmail.com>
 <20160718114723.GG27776@eguan.usersys.redhat.com> <CACj3i71VOC8i_11hFn_fphsMfGqduHB6on5UawUHm6mtAaVRhQ@mail.gmail.com>
 <CACj3i73hdbW4iAWufvxc_aJn1dj+UGzuud7Cj-qMiwe7aLeNxQ@mail.gmail.com>
 <20160720235433.GA12670@dastard> <CACj3i72UFhXeM-H8ubnso3CRH851Jp1nP-R-pP6AXZrABOeQMQ@mail.gmail.com>
 <20160721224057.GD12670@dastard>
From: Jan Tulak <jtulak@redhat.com>
Date: Fri, 22 Jul 2016 15:08:23 +0200
Message-ID: <CACj3i734fxMAJb+7SsDVieWREmfZgzZSJZagnewYZPgcyuXMmg@mail.gmail.com>
Subject: Re: [PATCH 6/6] xfstests: Add mkfs input validation tests
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, xfs-oss <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 22, 2016 at 12:40 AM, Dave Chinner <david@fromorbit.com> wrot=
e:
> On Thu, Jul 21, 2016 at 04:24:52PM +0200, Jan Tulak wrote:
>> On Thu, Jul 21, 2016 at 1:54 AM, Dave Chinner <david@fromorbit.com> wr=
ote:
>> >> >> I think you need to test on a 4k sector size disk. I use scsi_de=
bug to
>> >> >> simulate physical 4k sector disk to reproduce this:
>> >> >>
>> >> >> [root@dhcp-66-86-11 xfsprogs-dev]# modprobe -r scsi_debug
>> >> >> [root@dhcp-66-86-11 xfsprogs-dev]# modprobe scsi_debug dev_size_=
mb=3D128 physblk_exp=3D3
>> >> >> [root@dhcp-66-86-11 xfsprogs-dev]# blockdev --getbsz --getpbsz -=
-getss /dev/sdc
>> >> >> 4096
>> >> >> 4096
>> >> >> 512
>> >> >> [root@dhcp-66-86-11 xfsprogs-dev]# mkfs -t xfs -l version=3D1 -m=
 crc=3D1 /dev/sdc
>> >
>> > So this is an invalid filesystem configuration. It should be
>> > detected as such during command line parsing and rejected before we
>> > get anywhere near checking topology constraints. In mkfs
>> > terms, it's a conflicting option set.
>> >
>> >> And the culprit is in mkfs, some forty lines before the crc & log v=
ersion check:
>> >>
>> >> 2026 =E2=87=A5       } else if (lsectorsize > XFS_MIN_SECTORSIZE &&=
 !lsu && !lsunit) {
>> >> 2027 =E2=87=A5       =E2=87=A5       lsu =3D blocksize;
>> >> 2028 =E2=87=A5       =E2=87=A5       sb_feat.log_version =3D 2;
>> >> 2029 =E2=87=A5       }
>> >>
>> >> The possible solutions I can think of are:
>> >
>> > None of which really appeal because, IMO, they are trying to solve
>> > the wrong problem.
>> >
>> > The whole point of moving to table based command line option parsing
>> > is that we can encode these sorts of conflicts into the option
>> > table. The conflict resolution in the option table is currently not
>> > complete - it can only encode and detect conflicts within a
>> > suboption type, but not across suboption types (e.g. within -d
>> > suboptions, but not between -d and -l suboptions).
>> >
>> > This is simply because I never got as far as implementing this level
>> > of conflict encoding/resolution. In essence, the conflict array
>> > needs to define the sub option type, the suboption that is
>> > in conflict and the value that it conflicts against. Hence the
>> > conflicts table can then encode such things as "version 1 logs are
>> > invalid for CRC enabled filesystems" and vice versa.
>> >
>>
>> Ok, in long term, the correct way is to extend the conflicts table.
>
> Not long term. It's fairly simple to do.
>
> 1. Convert all the individual subopt parameter tables to an array of ta=
bles
>    with a defined index for each set of subopts,
> 2. add a value field to the parameter, and store the CLI value in
>    it when it is set
> 3. make the conflicts array in each subopts a structure like:
>
> struct conflicts {
>         int     subopt;
>         int     index;
>         int     invalid_value;
> };
>
> and convert all the existing conflicts to this format
>
> 4. Define cross-subopt conflicts like this:
>
>        .subopt_params =3D {
>                 { .index =3D M_CRC,
> -                 .conflicts =3D { LAST_CONFLICT },
> +                 .conflicts =3D { { LOG, L_VERSION, 1 },
> +                                { LAST_CONFLICT, 0, 0 }, },
>                   .minval =3D 0,
>                   .maxval =3D 1,
>                   .defaultval =3D 1,
>                 },
>
> And the L_VERSION subopt parameter will have a conflict like
>
> +                 .conflicts =3D { { META, M_CRC, 1 },
> +                                { LAST_CONFLICT, 0, 0 }, },
>
> 5. update the conflict lookup to do cross option lookups via
> checking the relevant option conflict table. e.g by checking the
> conflict[i].value against subopt[LOG].subopt_params[L_VERSION].value...
>
>> But what in the meantime? Are we going to let it be now until it is
>> fixed by the enhanced table?
>
> IMO: fix it once, fix it properly.
>
>> And regarding my question at the end of the mail, I interpret your
>> answer as "if the arguments are wrong, fail ASAP and don't try to fix
>> it."
>
> The first step in any program shoul dbe to validate user supplied
> inputs. Once they are validated and known good, you don't have to
> add random code to handle invalid combinations - you can just assume
> the inputs are valid to begin with and those corner cases don't need
> to be handled.
>

OK, thanks for showing the way, I will work on the changes.

In any case, to return to the beginning, the new test added by this
patch is all right.

Thanks,
Jan

--=20
Jan Tulak
jtulak@redhat.com / jan@tulak.me
