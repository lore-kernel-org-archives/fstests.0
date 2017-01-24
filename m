Received: from mx1.redhat.com ([209.132.183.28]:37718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbdAXDUO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Jan 2017 22:20:14 -0500
Date: Tue, 24 Jan 2017 11:20:13 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] mvtest: change "FSQA Test No." when we renumber tests
Message-ID: <20170124032013.GC1859@eguan.usersys.redhat.com>
References: <20170123185224.GF14029@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170123185224.GF14029@birch.djwong.org>
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 23, 2017 at 10:52:24AM -0800, Darrick J. Wong wrote:
> We have a number of tests (and submitters) who write tests containing
> "FSQA Test No." (as opposed to "FS QA Test No."), so update the mvtest
> script to change both forms.

Seems that's another reason to use "./new" to create test template :)

> 
> Also fix a sed bug that deletes too many group lines.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Thank you!

Eryu
