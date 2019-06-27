Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38178 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbfF0RRe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Jun 2019 13:17:34 -0400
Date: Thu, 27 Jun 2019 13:17:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fscrypt: document testing with xfstests
Message-ID: <20190627171728.GA31445@mit.edu>
References: <20190620181658.225792-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620181658.225792-1-ebiggers@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 20, 2019 at 11:16:58AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document how to test ext4, f2fs, and ubifs encryption with xfstests.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, you can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

					- Ted
