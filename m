Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57130 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726961AbfFXBmP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Jun 2019 21:42:15 -0400
Date: Sun, 23 Jun 2019 21:27:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 5/5] shared,generic: move tests using duperemove to
 generic/
Message-ID: <20190624012719.GC1805@mit.edu>
References: <20190623230956.24670-1-tytso@mit.edu>
 <20190623230956.24670-5-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623230956.24670-5-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 23, 2019 at 07:09:56PM -0400, Theodore Ts'o wrote:
> Add _require_scratch_duperemove which validates that the file system
> supports duperemove.  This allows us to move three tests from shared/

Hmmm, that should probably read, "... which validates that duperemove
supports file system being tested..."

					- Ted

> to generic/.  This means these tests will automatically adapt when
> duperemove supports other file systems.  Tests moved are:
> 
> 	shared/008 --> generic/559
> 	shared/009 --> generic/560
> 	shared/010 --> generic/561
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
