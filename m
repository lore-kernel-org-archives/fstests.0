Received: from imap.thunk.org ([74.207.234.97]:34818 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751479AbdFIDHi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Jun 2017 23:07:38 -0400
Date: Thu, 8 Jun 2017 23:07:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] xfstests-bld: misc: remove encrypt-test-revalidate
Message-ID: <20170609030735.wx6j3j3uvkcw6lna@thunk.org>
References: <20170608214627.136906-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608214627.136906-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 08, 2017 at 02:46:26PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The encrypt-test-revalidate script isn't useful anymore because what it
> did is now covered by xfstest generic/429.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted
