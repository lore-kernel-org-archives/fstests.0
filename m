Received: from imap.thunk.org ([74.207.234.97]:46444 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753556AbdLGOdj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Dec 2017 09:33:39 -0500
Date: Thu, 7 Dec 2017 09:33:29 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: False lockdep completion splats with loop device
Message-ID: <20171207143329.ioir5cx3fzyqpo4g@thunk.org>
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
 <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org>
 <20171205210956.GZ5858@dastard>
 <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com>
 <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
 <CAOQ4uxi76Er-a4-oejA894ws4t5w1OvLFBofJG03Tf6Ot+Usdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi76Er-a4-oejA894ws4t5w1OvLFBofJG03Tf6Ot+Usdg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Byungchul Park <byungchul.park@lge.com>, Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

Let me ask a potentially stupid question, Can someone give an example
of the problem this completion lockdep is actually trying to *catch*.
The lockdep message is sufficiently confusing it's not even clear what
*good* it is in the first place.

Is there an example of a bug that this lockdep feature hasf actually
caught in real life, as opposed to false positives?

							- Ted
