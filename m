Received: from mail-vk0-f43.google.com ([209.85.213.43]:34910 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759362AbdCVMeY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Mar 2017 08:34:24 -0400
Received: by mail-vk0-f43.google.com with SMTP id r69so13125743vke.2
        for <fstests@vger.kernel.org>; Wed, 22 Mar 2017 05:34:16 -0700 (PDT)
In-Reply-To: <20170321155512.GZ14226@eguan.usersys.redhat.com>
References: <20170315163347.29743-1-jtulak@redhat.com> <20170316074941.GS14226@eguan.usersys.redhat.com>
 <20170321152253.GB59313@bfoster.bfoster> <20170321155512.GZ14226@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Wed, 22 Mar 2017 13:33:55 +0100
Message-ID: <CACj3i73zH0f_saV21nD5=g6jYWStf0QfaV79tt5_UOheRY9zMA@mail.gmail.com>
Subject: Re: [PATCH] xfstests: xfs/191 update
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 21, 2017 at 4:55 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Tue, Mar 21, 2017 at 11:22:54AM -0400, Brian Foster wrote:
>> On Thu, Mar 16, 2017 at 03:49:41PM +0800, Eryu Guan wrote:
>> > On Wed, Mar 15, 2017 at 05:33:47PM +0100, Jan Tulak wrote:
>> > > The removed 'do_mkfs_pass -l size=3D4096b' was against man page
>> > > (-b section). Other entries are things that weren't covered before.
>> > >
>> > > Specifically, a standalone "-l size=3D4096b" should fail, because:
>> > > To  specify any options on the command line in units of filesys=E2=
=80=90
>> > > tem blocks, this option must be  specified  first  so  that  the
>> > > filesystem block size is applied consistently to all options.
>> > >
>> > > Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> >
>> > This looks fine to me. But I'd like some reviews from xfs developers
>> > too. (cc'd linux-xfs@vger.kernel.org).
>> >
>>
>> So has mkfs been fixed to cause '-l size=3D4096b' to fail? I'm not sure =
we
>> should cause the test to fail until/unless the mkfs behavior is fixed
>> up.
>
> I agreed, we don't want to update existing test and introduce false
> regressions. This is one of the reasons I want more reviews on this
> patch :)
>

I forgot to mention that this patch is a complement to my patchset for
mkfs.xfs. So yes, do not merge it now, it looks like the set won't get
merged yet. Sorry for not stating it in the description.

Jan


--=20
Jan Tulak
jtulak@redhat.com / jan@tulak.me
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIDaQ&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DdG0cxiQCPfpOfaaJhDEjEmvlhcF1qnO3R2meJjj_BKc&s=3Dn1HBnGdKSV0BvDaovv65anaY=
6jPnHRZLh17r-oRQ4Zc&e=3D=20
