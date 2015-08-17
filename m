Received: from mx3-phx2.redhat.com ([209.132.183.24]:42803 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbHQBFW convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 16 Aug 2015 21:05:22 -0400
Date: Sun, 16 Aug 2015 21:05:19 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <55490920.9057342.1439773519504.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150817000336.GE20596@dastard>
References: <1439482592-29611-1-git-send-email-zlang@redhat.com> <20150817000336.GE20596@dastard>
Subject: Re: [PATCH] generic/084: check inotify limit before tail many files
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Thanks for your reply.

----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org, eguan@redhat.com
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=80, 2015=
=E5=B9=B4 8 =E6=9C=88 17=E6=97=A5 =E4=B8=8A=E5=8D=88 8:03:36
> =E4=B8=BB=E9=A2=98: Re: [PATCH] generic/084: check inotify limit before=
 tail many files
>=20
> On Fri, Aug 14, 2015 at 12:16:32AM +0800, Zorro Lang wrote:
> > generic/084 try to run 'tail' command, tail will use
> > inotify, and there're some limit about inotify. I think
> > the most important is fs.inotify.max_user_instances, then
> > fs.inotify.max_user_watches is importand too.
> >
> > When I test on a machine with 154 cpu cores, this case
> > run failed, and hit many warning likes:
> >=20
> >     tail: inotify cannot be used, reverting to polling: Too many
> >     open files
> >=20
> > Because the fs.inotify.max_user_instances is 128, so if
> > we try to tail 154 files, it will be failed.
>=20
> We use 'tail' all over the place in xfstests, so why is only
> generic/084 affected?

Because generic/084 use try to create $nr_cpu tail processes:
for i in `seq 1 $nr_cpu`; do
    ...
    tail -f $testfile &
    ...
done

And nr_cpu=3D`$here/src/feature -o`.

Generally fs.inotify.max_user_instances is 128, when a machine
have more than(or nearly the same) this number, this test will
failed.

Maybe other cases don't try to create so many tail processes, so
they passed.

>=20
> And really, this seems more like a distro/environment bug and
> doesn't need xfstests help to work around. i.e. changing the
> sysctl before starting xfstests seems much more appropriate than
> hacking it a random test. Especially as there may be more than one
> test that is affected by this, and when run in a random order this
> would cause those other tests to pass/fail depending on whether
> generic/084 had already been run on that machine....

As this situation generally won't effect other cases, so I try to
make the patch don't effect more other cases. Because I don't know
if someone try to test fs.inotify...

But if maintainer think it'll be better, I will change the patch:)

Thanks,
Zorro Lang

>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>=20
