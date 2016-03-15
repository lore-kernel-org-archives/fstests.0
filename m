Received: from sandeen.net ([63.231.237.45]:37698 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932387AbcCOAgL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 14 Mar 2016 20:36:11 -0400
Subject: Re: [XFSTESTS v4 0/4] Richacl tests
References: <1457525199-15355-1-git-send-email-agruenba@redhat.com>
 <20160314222433.GC11812@dastard>
 <CAHc6FU4MqOqfzEeig-73An-9tQEgZE2BtWpjrs6ZPWB26x9AxQ@mail.gmail.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <56E758F7.900@sandeen.net>
Date: Mon, 14 Mar 2016 19:36:07 -0500
MIME-Version: 1.0
In-Reply-To: <CAHc6FU4MqOqfzEeig-73An-9tQEgZE2BtWpjrs6ZPWB26x9AxQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: xfs@oss.sgi.com, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 3/14/16 6:23 PM, Andreas Gruenbacher wrote:
> On Mon, Mar 14, 2016 at 11:24 PM, Dave Chinner <david@fromorbit.com> wrote:

<snip>

>> Most of this is as simple as copying the execution parts of your
>> scripts to the xfstests test scripts, and the output parts of the
>> test scripts into the test.out file. There's no new infrastructure
>> needed for running tests, no separate richacl/ script directory,
>> etc.
> 
> I've said again and again that maintaining one set of richacl tests in
> xfstests and another in the richacl package is going to really
> painful, and that because of that, I'm trying to find a way of using
> the same test scripts in both places. That message obviously didn't
> get through at all though. That is just sad.

Andreas, the issue as I see it is that xfstests is a large community
project, with many users who have come to understand its implementation
and its quirks^Wconventions.  It is run and maintained by many people;
over 150 authors have committed patches to the codebase.  They understand
how it all works together; it is a common language.

The way you are proposing your richacl tests integration is unlike any
other tests in the codebase; you have, to some degree, spliced your own
test harness into xfstests, rather than following the advice of
"When in Rome, do as the Romans do."

This might make your life a little easier if you plan to maintain
a separate repo of tests; in the meantime it makes life harder for the
150+ people who will be running and maintaining xfstests, not your
test repo.

The advantage of xfstests is that is is a common language, warts
and all.  It is run by developers and qa groups all over the world.
There is a learning curve, but many people have learned it.
Implementing your tests in this way adds a new and unique learning
curve for all those people, and will make it less likely that others
will share in the maintenance burden for these new tests.

What I would suggest is that if you have tests which test only
richacl userspace functionality, then perhaps you should keep
them private to the richacl package.  For tests which test kernel
functionality, make them native to xfstests.  This way you will get
good coverage and maintenance help from all the people testing
kernelspace with xfstests, and those hacking on richacls can run the
tests local to it.

This is more or less what e2fsprogs has done, and it seems to work
out ok.

-Eric

