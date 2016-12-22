Received: from imap.thunk.org ([74.207.234.97]:45316 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754590AbcLVRNV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Dec 2016 12:13:21 -0500
Date: Thu, 22 Dec 2016 12:13:14 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] xfstests-bld: remove redundant listing of GCE images
Message-ID: <20161222171313.ktsbjwo7ucmzn4lb@thunk.org>
References: <1482343592-135031-6-git-send-email-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482343592-135031-6-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 21, 2016 at 10:06:32AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When a GCE image is created, the same information about the new image
> was being printed by both 'gcloud compute images create' and 'gcloud
> compute images list'.  Fix this by removing the call to 'gcloud compute
> images list'.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

This was deliberate; the goal was to remind the image maintainer to
consider whether some of the older images should be GC'ed.

	 	      	     	   	  - Ted
