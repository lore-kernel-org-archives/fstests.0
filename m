Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:8843 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfDCVrM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Apr 2019 17:47:12 -0400
Date: Thu, 4 Apr 2019 08:47:08 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
Message-ID: <20190403214708.GA26298@dastard>
References: <20190402103428.21435-1-lhenriques@suse.com>
 <20190402103428.21435-3-lhenriques@suse.com>
 <20190402210931.GV23020@dastard>
 <87d0m3e81f.fsf@suse.com>
 <d38a4d84-8df2-984e-cf1c-045d85644796@suse.com>
 <874l7fdy5s.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874l7fdy5s.fsf@suse.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Luis Henriques <lhenriques@suse.com>
Cc: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 03, 2019 at 02:19:11PM +0100, Luis Henriques wrote:
> Nikolay Borisov <nborisov@suse.com> writes:
> > On 3.04.19 =D0=B3. 12:45 =D1=87., Luis Henriques wrote:
> >> Dave Chinner <david@fromorbit.com> writes:
> >>> Makes no sense to me. xfs_io does a write() loop internally with
> >>> this pwrite command of 4kB writes - the default buffer size. If you
> >>> want xfs_io to loop doing 1MB sized pwrite() calls, then all you
> >>> need is this:
> >>>
> >>> 	$XFS_IO_PROG -f -c "pwrite -w -B 1m 0 ${size}m" $file | _filter_xf=
s_io
> >>>
> >>=20
> >> Thank you for your review, Dave.  I'll make sure the next revision o=
f
> >> these tests will include all your comments implemented... except for
> >> this one.
> >>=20
> >> The reason I'm using a loop for writing a file is due to the nature =
of
> >> the (very!) loose definition of quotas in CephFS.  Basically, client=
s
> >> will likely write some amount of data over the configured limit beca=
use
> >> the servers they are communicating with to write the data (the OSDs)
> >> have no idea about the concept of quotas (or files even); the filesy=
stem
> >> view in the cluster is managed at a different level, with the help o=
f
> >> the MDS and the client itself.
> >>=20
> >> So, the loop in this function is simply to allow the metadata associ=
ated
> >> with the file to be updated while we're writing the file.  If I use =
a
> >
> > But the metadata will be modified while writing the file even with a
> > single invocation of xfs_io.
>=20
> No, that's not true.  It would be too expensive to keep the metadata
> server updated while writing to a file.  So, making sure there's
> actually an open/close to the file (plus the fsync in pwrite) helps
> making sure the metadata is flushed into the MDS.

/me sighs.

So you want:

	loop until ${size}MB written:
		write 1MB
		fsync
		  -> flush data to server
		  -> flush metadata to server

i.e. this one liner:

xfs_io -f -c "pwrite -D -B 1m 0 ${size}m" /path/to/file

Fundamentally, if you find yourself writing a loop around xfs_io to
break up a sequential IO stream into individual chunks, then you are
most likely doing something xfs_io can already do. And if xfs_io
cannot do it, then the right thing to do is to modify xfs_io to be
able to do it and then use xfs_io....

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
