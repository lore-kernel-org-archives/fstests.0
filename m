Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43369 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbfDNWPp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Apr 2019 18:15:45 -0400
Date: Mon, 15 Apr 2019 08:15:35 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
Message-ID: <20190414221535.GF1695@dread.disaster.area>
References: <20190402103428.21435-1-lhenriques@suse.com>
 <20190402103428.21435-3-lhenriques@suse.com>
 <20190402210931.GV23020@dastard>
 <87d0m3e81f.fsf@suse.com>
 <d38a4d84-8df2-984e-cf1c-045d85644796@suse.com>
 <874l7fdy5s.fsf@suse.com>
 <20190403214708.GA26298@dastard>
 <87tvfecbv5.fsf@suse.com>
 <20190412011559.GE1695@dread.disaster.area>
 <740207e9-b4ef-e4b4-4097-9ece2ac189a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <740207e9-b4ef-e4b4-4097-9ece2ac189a7@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Luis Henriques <lhenriques@suse.com>, Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, ceph-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 12, 2019 at 11:37:55AM +0800, Yan, Zheng wrote:
> On 4/12/19 9:15 AM, Dave Chinner wrote:
> > On Thu, Apr 04, 2019 at 11:18:22AM +0100, Luis Henriques wrote:
> > > Dave Chinner <david@fromorbit.com> writes:
> > >=20
> > > > On Wed, Apr 03, 2019 at 02:19:11PM +0100, Luis Henriques wrote:
> > > > > Nikolay Borisov <nborisov@suse.com> writes:
> > > > > > On 3.04.19 =D0=B3. 12:45 =D1=87., Luis Henriques wrote:
> > > > > > > Dave Chinner <david@fromorbit.com> writes:
> > > > > > > > Makes no sense to me. xfs_io does a write() loop internal=
ly with
> > > > > > > > this pwrite command of 4kB writes - the default buffer si=
ze. If you
> > > > > > > > want xfs_io to loop doing 1MB sized pwrite() calls, then =
all you
> > > > > > > > need is this:
> > > > > > > >=20
> > > > > > > > 	$XFS_IO_PROG -f -c "pwrite -w -B 1m 0 ${size}m" $file | =
_filter_xfs_io
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Thank you for your review, Dave.  I'll make sure the next r=
evision of
> > > > > > > these tests will include all your comments implemented... e=
xcept for
> > > > > > > this one.
> > > > > > >=20
> > > > > > > The reason I'm using a loop for writing a file is due to th=
e nature of
> > > > > > > the (very!) loose definition of quotas in CephFS.  Basicall=
y, clients
> > > > > > > will likely write some amount of data over the configured l=
imit because
> > > > > > > the servers they are communicating with to write the data (=
the OSDs)
> > > > > > > have no idea about the concept of quotas (or files even); t=
he filesystem
> > > > > > > view in the cluster is managed at a different level, with t=
he help of
> > > > > > > the MDS and the client itself.
> > > > > > >=20
> > > > > > > So, the loop in this function is simply to allow the metada=
ta associated
> > > > > > > with the file to be updated while we're writing the file.  =
If I use a
> > > > > >=20
> > > > > > But the metadata will be modified while writing the file even=
 with a
> > > > > > single invocation of xfs_io.
> > > > >=20
> > > > > No, that's not true.  It would be too expensive to keep the met=
adata
> > > > > server updated while writing to a file.  So, making sure there'=
s
> > > > > actually an open/close to the file (plus the fsync in pwrite) h=
elps
> > > > > making sure the metadata is flushed into the MDS.
> > > >=20
> > > > /me sighs.
> > > >=20
> > > > So you want:
> > > >=20
> > > > 	loop until ${size}MB written:
> > > > 		write 1MB
> > > > 		fsync
> > > > 		  -> flush data to server
> > > > 		  -> flush metadata to server
> > > >=20
> > > > i.e. this one liner:
> > > >=20
> > > > xfs_io -f -c "pwrite -D -B 1m 0 ${size}m" /path/to/file
> > >=20
> > > Unfortunately, that doesn't do what I want either :-/
> > > (and I guess you meant '-b 1m', not '-B 1m', right?)
> >=20
> > Yes. But I definitely did mean "-D" so that RWF_DSYNC was used with
> > each 1MB write.
> >=20
> > > [ Zheng: please feel free to correct me if I'm saying something rea=
lly
> > >    stupid below. ]
> > >=20
> > > So, one of the key things in my loop is the open/close operations. =
 When
> > > a file is closed in cephfs the capabilities (that's ceph jargon for=
 what
> > > sort of operations a client is allowed to perform on an inode) will
> > > likely be released and that's when the metadata server will get the
> > > updated file size.  Before that, the client is allowed to modify th=
e
> > > file size if it has acquired the capabilities for doing so.
> >=20
> > So you are saying that O_DSYNC writes on ceph do not force file
> > size metadata changes to the metadata server to be made stable?
> >=20
> > > OTOH, a pwrite operation will eventually get the -EDQUOT even with =
the
> > > one-liner above because the client itself will realize it has excee=
ded a
> > > certain threshold set by the MDS and will eventually update the ser=
ver
> > > with the new file size.
> >=20
> > Sure, but if the client crashes without having sent the updated file
> > size to the server as part of an extending O_DSYNC write, then how
> > is it recovered when the client reconnects to the server and
> > accesses the file again?
>=20
>=20
> For DSYNC write, client has already written data to object store. If cl=
ient
> crashes, MDS will set file to 'recovering' state and probe file size by
> checking object store. Accessing the file is blocked during recovery.

IOWs, ceph allows data integrity writes to the object store even
though those writes breach quota limits on that object store? i.e.
ceph quota essentially ignores O_SYNC/O_DSYNC metadata requirements?

FWIW, quotas normally have soft and hard limits - soft limits can be
breached with a warning and a time limit to return under the soft
limit, but the quota hard limit should /never/ be breached by users.

I guess that's the way of the world these days - fast and loose
because everyone demands fast before correct....

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
