Received: from bombadil.infradead.org ([65.50.211.133]:40708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdHLH0X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Aug 2017 03:26:23 -0400
Date: Sat, 12 Aug 2017 00:26:18 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fstests: add sdcardfs support
Message-ID: <20170812072618.GA13930@infradead.org>
References: <20170812001345.32850-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170812001345.32850-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: eguan@redhat.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 11, 2017 at 05:13:45PM -0700, Gwendal Grignou wrote:
> Add ability to run generic test on a sdcardfs filesystem.
> sdcardfs replaces fuse daemon to emulate a sdcard on Android.
> It is based on wrapfs, a passthru filesystem.

Please wait until the code is in mainline and all APIs/ABIs are stable.
