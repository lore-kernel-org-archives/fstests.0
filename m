Received: from mail-io0-f172.google.com ([209.85.223.172]:36130 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbcF3Icb convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2016 04:32:31 -0400
Received: by mail-io0-f172.google.com with SMTP id s63so65361899ioi.3
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2016 01:32:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160630033805.GP23649@eguan.usersys.redhat.com>
References: <1467212275-14344-1-git-send-email-jtulak@redhat.com> <20160630033805.GP23649@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 30 Jun 2016 10:32:10 +0200
Message-ID: <CACj3i73x6+-672TTE1JJDP2gb3MU47d4Rep7SG2tVpxxuF9Yog@mail.gmail.com>
Subject: Re: [PATCH] xfstests: Fix installation for extended names
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 30, 2016 at 5:38 AM, Eryu Guan <eguan@redhat.com> wrote:
> On Wed, Jun 29, 2016 at 04:57:55PM +0200, Jan Tulak wrote:
>> xfstests supports extended test names like 314-foo-bar, but installati=
on of
>> these tests was skipped (not matching a regexp). So this patch fixes t=
he
>> makefiles in tests directories.
>>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>
> Thanks for fixing it! But this breaks installation in other subdirs
>
> # make install
> ...
> ../../install-sh -o root -g root -m 755 [0-9]??-* /var/lib/xfstests/tes=
ts/btrfs
> cp: cannot stat =E2=80=98[0-9]??-*=E2=80=99: No such file or directory
> gmake[2]: *** [install] Error 1
> gmake[1]: *** [/root/xfstests/tests/btrfs/-install] Error 2
> make: *** [tests-install] Error 2
>

Hmm, yeah, I see... It fails when there is no such file to install.
I'm making it to ignore the error in the way:
-$(INSTALL) -m 755 [0-9]??-* $(TARGET_DIR) 2>/dev/null;true

It might hide some other issues (permissions...), but the chances are,
if something goes wrong, it goes wrong also with the standard
three-digit-names, where the error is not suppressed.

Thanks,
Jan


--=20
Jan Tulak
jtulak@redhat.com / jan@tulak.me
