Received: from imap.thunk.org ([74.207.234.97]:60620 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752991AbdDUF5V (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 Apr 2017 01:57:21 -0400
Date: Fri, 21 Apr 2017 01:57:18 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 3/3] android-xfstests: move ROOT_FS and ROOT_FS_URL into
 config.android
Message-ID: <20170421055718.xrqjtaten3sjhoxr@thunk.org>
References: <20170417213327.36520-1-ebiggers3@gmail.com>
 <20170417213327.36520-3-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417213327.36520-3-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Apr 17, 2017 at 02:33:27PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This allows them to be overridden by ~/.config/android-xfstests.  Also
> start treating an empty ROOT_FS_URL as meaning that no URL is provided.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks for the cleanup!  I've applied all three patches to my tree.

       	       		      	      	  - Ted
