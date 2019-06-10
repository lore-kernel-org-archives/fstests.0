Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58481 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387400AbfFJCx1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jun 2019 22:53:27 -0400
Date: Sun, 9 Jun 2019 22:53:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4/035: skip this test if DAX is in use
Message-ID: <20190610025317.GC3266@mit.edu>
References: <20190610024254.9830-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610024254.9830-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 09, 2019 at 10:42:54PM -0400, Theodore Ts'o wrote:
> This test creates a file system with a 1k block size.  Since there are
> no architectures with a 1k page size, test file system can never be

s/test file system/the test file system/

> mounted with DAX enabled, causing the test to fail.

Sorry, typo.

						- Ted
