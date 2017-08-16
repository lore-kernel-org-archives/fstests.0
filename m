Received: from mail-pg0-f54.google.com ([74.125.83.54]:37298 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdHPDpq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Aug 2017 23:45:46 -0400
Received: by mail-pg0-f54.google.com with SMTP id y129so17295898pgy.4
        for <fstests@vger.kernel.org>; Tue, 15 Aug 2017 20:45:46 -0700 (PDT)
Date: Tue, 15 Aug 2017 20:45:43 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [xfstests-bld PATCH 2/2] Make the build and creation of
 xfstests.tar.gz to be reproducible
Message-ID: <20170816034543.GC1417@zzz.localdomain>
References: <20170813173224.28900-1-tytso@mit.edu>
 <20170813173224.28900-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170813173224.28900-2-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Ted,

On Sun, Aug 13, 2017 at 01:32:24PM -0400, Theodore Ts'o wrote:
> +find xfstests -print0 | LC_ALL=C sort -z | \
> +    tar c --owner=0 --group=0 --numeric-owner --mtime="@${SOURCE_DATE_EPOCH}" \
> +    --mode=go+u-w --null --no-recursion -T - | $GZIP -9n > xfstests.tar.gz

This step isn't reproducible for me because earlier in the script $GZIP can be
set to pigz, which differs from gzip.  'gzip -n' omits the filename and
timestamp from the gz file, but 'pigz -n' only omits the filename, and the -T
option is needed to also omit the timestamp.  I think the following would work:

if type -P pigz >/dev/null; then
    GZIP="pigz -n -T"
else
    GZIP="gzip -n"
fi

Eric
