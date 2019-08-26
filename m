Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58284 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbfHZVNF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Aug 2019 17:13:05 -0400
Date: Mon, 26 Aug 2019 17:13:01 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common/casefold: only check for the Casefold flag
Message-ID: <20190826211301.GB28066@mit.edu>
References: <20190826175020.28959-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826175020.28959-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 26, 2019 at 01:50:20PM -0400, Theodore Ts'o wrote:
> The _casefold_lsattr_dir function lists all of the file attributes.
> As result, tests/generic/556.out has an ext4-specific assumption that
> files will have the Extents attribute.  That won't be true for all

"files" above should probably be changed "the test directories".

Eryu, can you make that change before you apply the patch, or do you
want me to resend?

> file systems, and it won't even be true for ext4 file systems that do
> not have the extents feature enabled.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

					- Ted
