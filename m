Received: from imap.thunk.org ([74.207.234.97]:56169 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbbKLQPz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 12 Nov 2015 11:15:55 -0500
Date: Thu, 12 Nov 2015 11:15:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] generic/310: make ext[2-4] error patterns more specific
Message-ID: <20151112161550.GA3431@thunk.org>
References: <1447288590-31937-1-git-send-email-tahsin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447288590-31937-1-git-send-email-tahsin@google.com>
Sender: fstests-owner@vger.kernel.org
To: Tahsin Erdogan <tahsin@google.com>
Cc: fstests@vger.kernel.org, Zhao Hongjiang <zhaohongjiang@huawei.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 11, 2015 at 04:36:30PM -0800, Tahsin Erdogan wrote:
> This test watches for ext[2-4] filesystem errors in kernel messages but it
> incorrectly identifies unrelated messages that contain string "error" as
> a failure condition.
> 
> Make grep pattern more specific to catch only relevant messages.
> 
> Signed-off-by: Tahsin Erdogan <tahsin@google.com>

The problem is this is a "generic" test, so it will be run on file
systems other than just ext[234].  So making the regexp's specific to
just ext[234] is probably going to be something acceptable for
xfstests upstream.

(For context, the problem was that there were some kernel messages
coming fom an i2c device driver that happened to be spit out while
generic/310 was running, this was causing a false test failure.)

Alternate possible fixes:

(1) we could make an ext4 version of this test, and then make
generic/310 not run for ext4.  In that case we can use the EXT[234]-fs
specific error.

(2) we can fiter out the i2c error in generic/310

(3) we can figure out why the i2c device driver is randomly spitting
out errors and ask the team responsible for that driver to fix _that_
bug

(4) we can try to enumerate the file system specific error messages
instead of assuming that any random kernel message that happens to
contain the string "error" automatically means that there is a file
system problem.

We should probably do (3) no matter what, and arguably generic/310 is
a badly written test and if there is some way we can do (4), that
would be desirable.  As a fall back, we could do (2), and see if that
is acceptable for xfstests upstream.

Cheers,

						- Ted
