Received: from mail-it1-f194.google.com ([209.85.166.194]:51815 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbfDPSip (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Apr 2019 14:38:45 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so409947itk.1
        for <fstests@vger.kernel.org>; Tue, 16 Apr 2019 11:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190402210931.GV23020@dastard> <87d0m3e81f.fsf@suse.com>
 <d38a4d84-8df2-984e-cf1c-045d85644796@suse.com> <874l7fdy5s.fsf@suse.com>
 <20190403214708.GA26298@dastard> <87tvfecbv5.fsf@suse.com>
 <20190412011559.GE1695@dread.disaster.area> <740207e9-b4ef-e4b4-4097-9ece2ac189a7@redhat.com>
 <20190414221535.GF1695@dread.disaster.area> <0cbc6885-93ae-ca79-184e-cdc56681202c@redhat.com>
 <20190416081356.GB1454@dread.disaster.area> <874l6yrztf.fsf@suse.com>
In-Reply-To: <874l6yrztf.fsf@suse.com>
From: Gregory Farnum <gfarnum@redhat.com>
Date: Tue, 16 Apr 2019 11:38:32 -0700
Message-ID: <CAJ4mKGbN1W-rZLE=GSd3qE8hyLyHbvUHXbX3PCV2W9ukqrBvJg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, "Yan, Zheng" <zyan@redhat.com>, Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, ceph-devel <ceph-devel@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 16, 2019 at 3:48 AM Luis Henriques <lhenriques@suse.com> wrote:
>
> Dave Chinner <david@fromorbit.com> writes:
>
> > On Mon, Apr 15, 2019 at 10:16:18AM +0800, Yan, Zheng wrote:
> >> On 4/15/19 6:15 AM, Dave Chinner wrote:
> >> > On Fri, Apr 12, 2019 at 11:37:55AM +0800, Yan, Zheng wrote:
> >> > > On 4/12/19 9:15 AM, Dave Chinner wrote:
> >> > > > On Thu, Apr 04, 2019 at 11:18:22AM +0100, Luis Henriques wrote:
> >> > > > > Dave Chinner <david@fromorbit.com> writes:
> >> > > For DSYNC write, client has already written data to object store. If client
> >> > > crashes, MDS will set file to 'recovering' state and probe file size by
> >> > > checking object store. Accessing the file is blocked during recovery.
> >> >
> >> > IOWs, ceph allows data integrity writes to the object store even
> >> > though those writes breach  limits on that object store? i.e.
> >> > ceph quota essentially ignores O_SYNC/O_DSYNC metadata requirements?
> >> >
> >>
> >> Current cephfs quota implementation checks quota (compare i_size and quota
> >> setting) at very beginning of ceph_write_iter(). Nothing do with O_SYNC and
> >> O_DSYNC.
> >
> > Hold on, if the quota is checked on the client at the start of every
> > write, then why is it not enforced /exactly/? Where does this "we
> > didn't notice we'd run out of quota" overrun come from then?
>
> Ok, there's an extra piece of information that I don't think it was
> mentioned in the thread yet, which is the (recursive) directory
> statistics.  These stats are maintained by the MDS and it's against
> these stats that the client actually checks if there's an overrun.  The
> checks can be done against the amount of bytes ('max_bytes' quota)
> and/or number of files ('max_files' quota), depending on which quotas
> are enabled.
>
> _Maybe_ there's space for some optimization on the client-side by
> locally updating the stats received from the MDS with local writes,
> files creation/deletion, etc.  But I'm not sure it's worth the effort,
> because:
>
> - for each operation (write, truncate, create, ...) we would also have
>   the extra overhead of walking up the directory tree (or at least the
>   quota realms tree) to update the stats for each directory;  and
>
> - we may have more clients writing to the same directories, and thus
>   messing up with the dir quotas anyway.  I.e. the quotas overrun
>   problem would still be there, and we would still require to open/close
>   files in the test.
>
> Hopefully this helps clarifying why the open/close loop is a needed hack
> with the current quotas design.

More broadly, and without reference to any specific design, Ceph is a
distributed storage system that allows multiple active clients to
independently do activity against multiple servers, and which allows
directory quotas.

Strict enforcement of quotas requires a single centralized authority
to know the data within each directory and decide on every individual
write operation if there is enough space to allow it; this is easy on
a local filesystem but fundamentally cripples a multi-computer one
since it implies serializing every IO on a single server. (Yes, there
are LOTS of tricks you can pull so that "normally" it's not a problem
and only impacts IO when you are actually approaching the quota limit;
yes, there are ways to try and proactively reserve quota for a given
writer; they all break down into the "contact a single server and
serialize on it" when you actually approach the quota and nobody has
yet expressed any interest in Ceph's quotas being that precise
anyway.)

>
> Cheers,
> --
> Luis
>
> >
> > i.e. the test changes are implying that quota is not accurately
> > checked and enforced on every write, and that there is something
> > less that exact about quotas on the ceph client. Yet you say they
> > are checked on every write.
> >
> > Where does the need to open/close files and force flushing client
> > state to the MDS come from if quota is actually being checked
> > on every write as you say it is?
> >
> > i.e. I'm trying to work out if this change is just working around
> > bugs in ceph quota accounting and I'm being told conflicting things
> > about how the ceph client accounts and enforces quota limits. Can
> > you please clearly explain how the quota enforcedment works and why
> > close/open between writes is necessary for accurate quota
> > enforcement so that we have some clue as to why these rubbery limit
> > hacks are necessary?
> >
> > If we don't understand why a test does something and it's not
> > adequately documented, we can't really be expected to maintain
> > it in working order....
> >
> > Cheers,
> >
> > Dave.
