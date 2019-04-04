Received: from mx2.suse.de ([195.135.220.15]:60892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfDDKS0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Apr 2019 06:18:26 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
References: <20190402103428.21435-1-lhenriques@suse.com>
        <20190402103428.21435-3-lhenriques@suse.com>
        <20190402210931.GV23020@dastard> <87d0m3e81f.fsf@suse.com>
        <d38a4d84-8df2-984e-cf1c-045d85644796@suse.com>
        <874l7fdy5s.fsf@suse.com> <20190403214708.GA26298@dastard>
Date: Thu, 04 Apr 2019 11:18:22 +0100
In-Reply-To: <20190403214708.GA26298@dastard> (Dave Chinner's message of "Thu,
        4 Apr 2019 08:47:08 +1100")
Message-ID: <87tvfecbv5.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Wed, Apr 03, 2019 at 02:19:11PM +0100, Luis Henriques wrote:
>> Nikolay Borisov <nborisov@suse.com> writes:
>> > On 3.04.19 =D0=B3. 12:45 =D1=87., Luis Henriques wrote:
>> >> Dave Chinner <david@fromorbit.com> writes:
>> >>> Makes no sense to me. xfs_io does a write() loop internally with
>> >>> this pwrite command of 4kB writes - the default buffer size. If yo=
u
>> >>> want xfs_io to loop doing 1MB sized pwrite() calls, then all you
>> >>> need is this:
>> >>>
>> >>> 	$XFS_IO_PROG -f -c "pwrite -w -B 1m 0 ${size}m" $file | _filter_x=
fs_io
>> >>>
>> >>=20
>> >> Thank you for your review, Dave.  I'll make sure the next revision =
of
>> >> these tests will include all your comments implemented... except fo=
r
>> >> this one.
>> >>=20
>> >> The reason I'm using a loop for writing a file is due to the nature=
 of
>> >> the (very!) loose definition of quotas in CephFS.  Basically, clien=
ts
>> >> will likely write some amount of data over the configured limit bec=
ause
>> >> the servers they are communicating with to write the data (the OSDs=
)
>> >> have no idea about the concept of quotas (or files even); the files=
ystem
>> >> view in the cluster is managed at a different level, with the help =
of
>> >> the MDS and the client itself.
>> >>=20
>> >> So, the loop in this function is simply to allow the metadata assoc=
iated
>> >> with the file to be updated while we're writing the file.  If I use=
 a
>> >
>> > But the metadata will be modified while writing the file even with a
>> > single invocation of xfs_io.
>>=20
>> No, that's not true.  It would be too expensive to keep the metadata
>> server updated while writing to a file.  So, making sure there's
>> actually an open/close to the file (plus the fsync in pwrite) helps
>> making sure the metadata is flushed into the MDS.
>
> /me sighs.
>
> So you want:
>
> 	loop until ${size}MB written:
> 		write 1MB
> 		fsync
> 		  -> flush data to server
> 		  -> flush metadata to server
>
> i.e. this one liner:
>
> xfs_io -f -c "pwrite -D -B 1m 0 ${size}m" /path/to/file

Unfortunately, that doesn't do what I want either :-/
(and I guess you meant '-b 1m', not '-B 1m', right?)

[ Zheng: please feel free to correct me if I'm saying something really
  stupid below. ]

So, one of the key things in my loop is the open/close operations.  When
a file is closed in cephfs the capabilities (that's ceph jargon for what
sort of operations a client is allowed to perform on an inode) will
likely be released and that's when the metadata server will get the
updated file size.  Before that, the client is allowed to modify the
file size if it has acquired the capabilities for doing so.

OTOH, a pwrite operation will eventually get the -EDQUOT even with the
one-liner above because the client itself will realize it has exceeded a
certain threshold set by the MDS and will eventually update the server
with the new file size.  However that won't happen at a deterministic
file size.  For example, if quota is 10m and we're writing 20m, we may
get the error after writing 15m.

Does this make sense?

So, I guess I *could* use your one-liner in the test, but I would need
to slightly change the test logic -- I would need to write enough data
to the file to make sure I would get the -EDQUOT but I wouldn't be able
to actually check the file size as it will not be constant.

> Fundamentally, if you find yourself writing a loop around xfs_io to
> break up a sequential IO stream into individual chunks, then you are
> most likely doing something xfs_io can already do. And if xfs_io
> cannot do it, then the right thing to do is to modify xfs_io to be
> able to do it and then use xfs_io....

Got it!  But I guess it wouldn't make sense to change xfs_io for this
specific scenario where I want several open-write-close cycles.

Cheers,
--=20
Luis
