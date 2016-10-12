Received: from mail-pa0-f46.google.com ([209.85.220.46]:34527 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756025AbcJLVaV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Oct 2016 17:30:21 -0400
Received: by mail-pa0-f46.google.com with SMTP id rz1so31881029pab.1
        for <fstests@vger.kernel.org>; Wed, 12 Oct 2016 14:30:20 -0700 (PDT)
Date: Wed, 12 Oct 2016 14:30:11 -0700
From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 RESEND] posix_acl: Clear SGID bit when setting file
 permissions
Message-ID: <20161012213011.GB120419@google.com>
References: <1474299768-15150-1-git-send-email-jack@suse.cz>
 <20161011231101.GB126173@google.com>
 <20161012071651.GB13896@quack2.suse.cz>
 <20161012173549.GA120419@google.com>
 <20161012211630.GM23194@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161012211630.GM23194@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 13, 2016 at 08:16:30AM +1100, Dave Chinner wrote:
> 
> Send patches to fix/update the tests.
> 

I will do so.

Eric
