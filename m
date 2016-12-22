Received: from imap.thunk.org ([74.207.234.97]:45112 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755550AbcLVRHj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Dec 2016 12:07:39 -0500
Date: Thu, 22 Dec 2016 12:07:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: include f2fs userspace tools in test
 appliances
Message-ID: <20161222170737.x3ento5occiotnm5@thunk.org>
References: <1482343592-135031-3-git-send-email-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482343592-135031-3-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 21, 2016 at 10:06:29AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Sure, applied.  I hadn't bothered because I built a newer version of
f2fs-tools from the git repository as a debian package and dropped it
in kvm-xfststs/test-appliance/debs.  It's been on my todo list work
with the Debian maintainer to get a newer version into
jessie-backports....

						- Ted
