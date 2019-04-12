Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59933 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbfDLBi3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Apr 2019 21:38:29 -0400
Date: Fri, 12 Apr 2019 11:15:59 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
Message-ID: <20190412011559.GE1695@dread.disaster.area>
References: <20190402103428.21435-1-lhenriques@suse.com>
 <20190402103428.21435-3-lhenriques@suse.com>
 <20190402210931.GV23020@dastard>
 <87d0m3e81f.fsf@suse.com>
 <d38a4d84-8df2-984e-cf1c-045d85644796@suse.com>
 <874l7fdy5s.fsf@suse.com>
 <20190403214708.GA26298@dastard>
 <87tvfecbv5.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvfecbv5.fsf@suse.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Luis Henriques <lhenriques@suse.com>
Cc: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 04, 2019 at 11:18:22AM +0100, Luis Henriques wrote:
> Dave Chinner <david@fromorbit.com> writes:
>=20
> > On Wed, Apr 03, 2019 at 02:19:11PM +0100, Luis Henriques wrote:
> >> Nikolay Borisov <nborisov@suse.com> writes:
> >> > On 3.04.19 =D0=B3. 12:45 =D1=87., Luis Henriques wrote:
> >> >> Dave Chinner <david@fromorbit.com> writes:
> >> >>> Makes no sense to me. xfs_io does a write() loop internally with
> >> >>> this pwrite command of 4kB writes - the default buffer size. If =
you
> >> >>> want xfs_io to loop doing 1MB sized pwrite() calls, then all you
> >> >>> need is this:
> >> >>>
> >> >>> 	$XFS_IO_PROG -f -c "pwrite -w -B 1m 0 ${size}m" $file | _filter=
_xfs_io
> >> >>>
> >> >>=20
> >> >> Thank you for your review, Dave.  I'll make sure the next revisio=
n of
> >> >> these tests will include all your comments implemented... except =
for
> >> >> this one.
> >> >>=20
> >> >> The reason I'm using a loop for writing a file is due to the natu=
re of
> >> >> the (very!) loose definition of quotas in CephFS.  Basically, cli=
ents
> >> >> will likely write some amount of data over the configured limit b=
ecause
> >> >> the servers they are communicating with to write the data (the OS=
Ds)
> >> >> have no idea about the concept of quotas (or files even); the fil=
esystem
> >> >> view in the cluster is managed at a different level, with the hel=
p of
> >> >> the MDS and the client itself.
> >> >>=20
> >> >> So, the loop in this function is simply to allow the metadata ass=
ociated
> >> >> with the file to be updated while we're writing the file.  If I u=
se a
> >> >
> >> > But the metadata will be modified while writing the file even with=
 a
> >> > single invocation of xfs_io.
> >>=20
> >> No, that's not true.  It would be too expensive to keep the metadata
> >> server updated while writing to a file.  So, making sure there's
> >> actually an open/close to the file (plus the fsync in pwrite) helps
> >> making sure the metadata is flushed into the MDS.
> >
> > /me sighs.
> >
> > So you want:
> >
> > 	loop until ${size}MB written:
> > 		write 1MB
> > 		fsync
> > 		  -> flush data to server
> > 		  -> flush metadata to server
> >
> > i.e. this one liner:
> >
> > xfs_io -f -c "pwrite -D -B 1m 0 ${size}m" /path/to/file
>=20
> Unfortunately, that doesn't do what I want either :-/
> (and I guess you meant '-b 1m', not '-B 1m', right?)

Yes. But I definitely did mean "-D" so that RWF_DSYNC was used with
each 1MB write.

> [ Zheng: please feel free to correct me if I'm saying something really
>   stupid below. ]
>=20
> So, one of the key things in my loop is the open/close operations.  Whe=
n
> a file is closed in cephfs the capabilities (that's ceph jargon for wha=
t
> sort of operations a client is allowed to perform on an inode) will
> likely be released and that's when the metadata server will get the
> updated file size.  Before that, the client is allowed to modify the
> file size if it has acquired the capabilities for doing so.

So you are saying that O_DSYNC writes on ceph do not force file
size metadata changes to the metadata server to be made stable?

> OTOH, a pwrite operation will eventually get the -EDQUOT even with the
> one-liner above because the client itself will realize it has exceeded =
a
> certain threshold set by the MDS and will eventually update the server
> with the new file size.

Sure, but if the client crashes without having sent the updated file
size to the server as part of an extending O_DSYNC write, then how
is it recovered when the client reconnects to the server and
accesses the file again?

> However that won't happen at a deterministic
> file size.  For example, if quota is 10m and we're writing 20m, we may
> get the error after writing 15m.
>=20
> Does this make sense?

Only makes sense to me if O_DSYNC is ignored by the ceph client...

> So, I guess I *could* use your one-liner in the test, but I would need
> to slightly change the test logic -- I would need to write enough data
> to the file to make sure I would get the -EDQUOT but I wouldn't be able
> to actually check the file size as it will not be constant.
>=20
> > Fundamentally, if you find yourself writing a loop around xfs_io to
> > break up a sequential IO stream into individual chunks, then you are
> > most likely doing something xfs_io can already do. And if xfs_io
> > cannot do it, then the right thing to do is to modify xfs_io to be
> > able to do it and then use xfs_io....
>=20
> Got it!  But I guess it wouldn't make sense to change xfs_io for this
> specific scenario where I want several open-write-close cycles.

That's how individual NFS client writes appear to filesystem under
the NFS server. I've previously considered adding an option in
xfs_io to mimic this open-write-close loop per buffer so it's easy
to exercise such behaviours, but never actually required it to
reproduce the problems I was chasing. So it's definitely something
that xfs_io /could/ do if necessary.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
