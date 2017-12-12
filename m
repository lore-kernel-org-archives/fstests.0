Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:16867
        "EHLO ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751877AbdLLASK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Dec 2017 19:18:10 -0500
Date: Tue, 12 Dec 2017 11:18:06 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 3/3] generic/470: add syncfs test
Message-ID: <20171212001806.GS4094@dastard>
References: <1512613327-218016-3-git-send-email-cgxu519@icloud.com>
 <20171207054418.GC2749@eguan.usersys.redhat.com>
 <423B3F2E-73F1-4B29-93D7-BC6F1AA6CCC6@icloud.com>
 <20171207071317.GE2749@eguan.usersys.redhat.com>
 <EB49C2D0-6500-4588-803F-40F4B9FA6DE3@icloud.com>
 <CAOQ4uxgiqZBKUksWv-0gomKP4Ov7NB6zUw2TdnzUz7x6VUcpUw@mail.gmail.com>
 <E541A51A-D9B3-4596-8222-453132512449@icloud.com>
 <CAOQ4uxjxtGd1+empZGX3OMXnYQoZ1YvL-HmKBUh3CBgFs2F1Aw@mail.gmail.com>
 <A23C2505-1097-4331-8290-F333FB57D464@icloud.com>
 <CAOQ4uxgjJzbFq92jfkRguU-JQftb57SfTqt-f5NPaLip2LVjNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgjJzbFq92jfkRguU-JQftb57SfTqt-f5NPaLip2LVjNg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chengguang Xu <cgxu519@icloud.com>, Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Dec 11, 2017 at 02:44:50PM +0200, Amir Goldstein wrote:
> On Mon, Dec 11, 2017 at 2:33 PM, Chengguang Xu <cgxu519@icloud.com> wro=
te:
> >>
> >> =E5=9C=A8 2017=E5=B9=B412=E6=9C=8811=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=
=886:46=EF=BC=8CAmir Goldstein <amir73il@gmail.com> =E5=86=99=E9=81=93=EF=
=BC=9A
> >>
> >> On Mon, Dec 11, 2017 at 12:03 PM, Chengguang Xu <cgxu519@icloud.com>=
 wrote:
> >>>>
> >>>> =E5=9C=A8 2017=E5=B9=B412=E6=9C=887=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=
=884:17=EF=BC=8CAmir Goldstein <amir73il@gmail.com> =E5=86=99=E9=81=93=EF=
=BC=9A
> >> [...]
> >>>
> >>> I did more detail tests for three different data modes of ext4 and =
found
> >>> the overlayfs syncfs bug is reproducible on data=3Dordered and data=
=3Dwriteback,
> >>> but on data=3Djournal mode, data is flushed and correct.
> >>
> >> That is expected, because overlayfs does call upper's sync_fs() meth=
od and
> >> for journal=3Ddata that will flush all dirty pages as well.
> >>
> >>> I only wrote only a few words
> >>> to a single file and the bug is always reproducible on my test envi=
ronment.
> >>>
> >>> For writeback interferences, AFAIK, from dirty ratio and period.
> >>> If we drop all dirty caches & sync before the test, I think we can
> >>> avoid interference from it.
> >>>
> >>
> >> Why? does either drop_caches or sync() reset the flusher thread
> >> periodic flush dirty pages?
> >
> > Sorry=EF=BC=8CWe have to finish test in 30 seconds after we write tes=
t file,
> > otherwise may be affected by background flusher.
> >
> >
> >>
> >>> So if we don=E2=80=99t have anything else to interference test resu=
lt,
> >>> I just want to modify to write a small single file as test target.
> >>>
> >>> Am I missing anything?
> >>
> >> I think the chance of flusher thread interfering the test and
> >> flushing the dirty page you wrote before _scratch_shutdown exists,
> >> but is small enough so we can neglect it and keep the test as simple
> >> as possible.
> >
> > As I know, in normal case flusher thread check dirty inode expiring e=
very 5 seconds(default) and flush dirty
> > inode when expires 30 seconds(default). If we can finish test in 30s =
after running test, it would be OK.
> > What do you think?
> >
>=20
> 5 seconds is ext4 default journal commit interval. this is when dirty
> metadata will be flushed.
> 30 is generic flusher thread interval.
> What if test started 29 seconds after last flush?

Then the inode is only 1 second "old" when the flush occurs and so
it gets ignored. it'll get flushed only once it's been dirty for
longer than a flusher thread interval.

IIRC there's quite a few tests where we make the assumption we've
got at least 30s before the dirty cached data will be written by the
kernel. e.g. for shutting down the filesystem before data hits the
disk to test metadata vs data recovery state.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
