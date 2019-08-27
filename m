Received: from Galois.linutronix.de ([193.142.43.55]:42205 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfH0GN2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 27 Aug 2019 02:13:28 -0400
Date: Tue, 27 Aug 2019 08:13:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] generic: test for failure to unlock inode after chgrp
 fails with EDQUOT
In-Reply-To: <20190827041816.GB1037528@magnolia>
Message-ID: <alpine.DEB.2.21.1908270811030.1939@nanos.tec.linutronix.de>
References: <20190827041816.GB1037528@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Christoph Hellwig <hch@infradead.org>, xfs <linux-xfs@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, Salvatore Bonaccorso <carnil@debian.org>, Security Officers <security@kernel.org>, Debian Security Team <team@security.debian.org>, benjamin.moody@gmail.com, Ben Hutchings <benh@debian.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, 26 Aug 2019, Darrick J. Wong wrote:
> +++ b/tests/generic/719
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-newer

Please run scripts/spdxcheck.py on that file and consult the licensing
documentation.

Thanks,

	tglx
