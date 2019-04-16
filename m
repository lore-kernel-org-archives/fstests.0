Received: from mx2.suse.de ([195.135.220.15]:55016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbfDPKsQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Apr 2019 06:48:16 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
References: <20190402210931.GV23020@dastard> <87d0m3e81f.fsf@suse.com>
        <d38a4d84-8df2-984e-cf1c-045d85644796@suse.com>
        <874l7fdy5s.fsf@suse.com> <20190403214708.GA26298@dastard>
        <87tvfecbv5.fsf@suse.com> <20190412011559.GE1695@dread.disaster.area>
        <740207e9-b4ef-e4b4-4097-9ece2ac189a7@redhat.com>
        <20190414221535.GF1695@dread.disaster.area>
        <0cbc6885-93ae-ca79-184e-cdc56681202c@redhat.com>
        <20190416081356.GB1454@dread.disaster.area>
Date: Tue, 16 Apr 2019 11:48:12 +0100
In-Reply-To: <20190416081356.GB1454@dread.disaster.area> (Dave Chinner's
        message of "Tue, 16 Apr 2019 18:13:56 +1000")
Message-ID: <874l6yrztf.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, ceph-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Mon, Apr 15, 2019 at 10:16:18AM +0800, Yan, Zheng wrote:
>> On 4/15/19 6:15 AM, Dave Chinner wrote:
>> > On Fri, Apr 12, 2019 at 11:37:55AM +0800, Yan, Zheng wrote:
>> > > On 4/12/19 9:15 AM, Dave Chinner wrote:
>> > > > On Thu, Apr 04, 2019 at 11:18:22AM +0100, Luis Henriques wrote:
>> > > > > Dave Chinner <david@fromorbit.com> writes:
>> > > For DSYNC write, client has already written data to object store. If client
>> > > crashes, MDS will set file to 'recovering' state and probe file size by
>> > > checking object store. Accessing the file is blocked during recovery.
>> > 
>> > IOWs, ceph allows data integrity writes to the object store even
>> > though those writes breach  limits on that object store? i.e.
>> > ceph quota essentially ignores O_SYNC/O_DSYNC metadata requirements?
>> > 
>> 
>> Current cephfs quota implementation checks quota (compare i_size and quota
>> setting) at very beginning of ceph_write_iter(). Nothing do with O_SYNC and
>> O_DSYNC.
>
> Hold on, if the quota is checked on the client at the start of every
> write, then why is it not enforced /exactly/? Where does this "we
> didn't notice we'd run out of quota" overrun come from then?

Ok, there's an extra piece of information that I don't think it was
mentioned in the thread yet, which is the (recursive) directory
statistics.  These stats are maintained by the MDS and it's against
these stats that the client actually checks if there's an overrun.  The
checks can be done against the amount of bytes ('max_bytes' quota)
and/or number of files ('max_files' quota), depending on which quotas
are enabled.

_Maybe_ there's space for some optimization on the client-side by
locally updating the stats received from the MDS with local writes,
files creation/deletion, etc.  But I'm not sure it's worth the effort,
because:

- for each operation (write, truncate, create, ...) we would also have
  the extra overhead of walking up the directory tree (or at least the
  quota realms tree) to update the stats for each directory;  and

- we may have more clients writing to the same directories, and thus
  messing up with the dir quotas anyway.  I.e. the quotas overrun
  problem would still be there, and we would still require to open/close
  files in the test.

Hopefully this helps clarifying why the open/close loop is a needed hack
with the current quotas design.

Cheers,
-- 
Luis

>
> i.e. the test changes are implying that quota is not accurately
> checked and enforced on every write, and that there is something
> less that exact about quotas on the ceph client. Yet you say they
> are checked on every write.
>
> Where does the need to open/close files and force flushing client
> state to the MDS come from if quota is actually being checked
> on every write as you say it is?
>
> i.e. I'm trying to work out if this change is just working around
> bugs in ceph quota accounting and I'm being told conflicting things
> about how the ceph client accounts and enforces quota limits. Can
> you please clearly explain how the quota enforcedment works and why
> close/open between writes is necessary for accurate quota
> enforcement so that we have some clue as to why these rubbery limit
> hacks are necessary?
>
> If we don't understand why a test does something and it's not
> adequately documented, we can't really be expected to maintain
> it in working order....
>
> Cheers,
>
> Dave.
