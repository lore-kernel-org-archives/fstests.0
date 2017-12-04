Received: from imap.thunk.org ([74.207.234.97]:56568 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751828AbdLDA2s (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 3 Dec 2017 19:28:48 -0500
Date: Sun, 3 Dec 2017 19:28:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/2] generic/456: document the fix commit
Message-ID: <20171204002838.kicldlczz645hwfw@thunk.org>
References: <1511419423-7905-1-git-send-email-amir73il@gmail.com>
 <1511419423-7905-2-git-send-email-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511419423-7905-2-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <eguan@redhat.com>, Josef Bacik <jbacik@fb.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Nov 23, 2017 at 08:43:43AM +0200, Amir Goldstein wrote:
> Add a link to Ted's post with more details about the bug
> and the fix.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I'm OK with this, so:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

> It may be better to include a digest of the refered post embedded
> in the test. For now, I just added the link to mailing list archive.
> Maybe Ted can add the digest later.

Eryu can chime in if he links, but in general we haven't included long
discourses describing the bug in xfstests, so I don't think that's
really necessary.

					- Ted
