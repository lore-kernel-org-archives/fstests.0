Received: from imap.thunk.org ([74.207.234.97]:44092 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750910AbdA3XaD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Jan 2017 18:30:03 -0500
Date: Mon, 30 Jan 2017 18:01:22 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2] gce-xfstests: include extra debian packages when
 building GCE image
Message-ID: <20170130230122.2uagagvk25dezn5n@thunk.org>
References: <20170130213619.14733-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170130213619.14733-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 30, 2017 at 01:36:19PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Extra Debian packages in the kvm-xfstests/test-appliance/debs/ directory
> were getting added to kvm-xfstests appliances but not to gce-xfstests
> appliances.  Make them get added to gce-xfstests appliances as well, and
> document this in gce-xfstests.md.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

The functional bits were added upstream in commit e1ef1f57.  I'll pull
in your documentation change, thanks.

						- Ted
