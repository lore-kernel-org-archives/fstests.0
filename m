Received: from imap.thunk.org ([74.207.234.97]:39000 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757367AbdERSpm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 18 May 2017 14:45:42 -0400
Date: Thu, 18 May 2017 14:45:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/5] kernel-configs: remove ext4- prefix from
 kernel-configs
Message-ID: <20170518184540.h64ga3quza3oxffw@thunk.org>
References: <20170517233233.61244-1-ebiggers3@gmail.com>
 <20170517233233.61244-3-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517233233.61244-3-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, May 17, 2017 at 04:32:30PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The kvm-xfstests/gce-xfstests kernel configs already have multiple
> filesystems enabled, and I'd like to enable some more filesystems, so
> remove the "ext4-" prefix from the config filenames.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
