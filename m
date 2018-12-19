Received: from bombadil.infradead.org ([198.137.202.133]:37076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSHSe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Dec 2018 02:18:34 -0500
Date: Tue, 18 Dec 2018 23:18:34 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1] xfstests: filter the default EA
Message-ID: <20181219071834.GA14993@infradead.org>
References: <1545191068-6719-1-git-send-email-xifeng@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545191068-6719-1-git-send-email-xifeng@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: XiaoLi Feng <xifeng@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 19, 2018 at 11:44:28AM +0800, XiaoLi Feng wrote:
> From: xiaoli feng <xifeng@redhat.com>
> 
> For some filesystems, such as CIFS, the file or directory has the
> default extend attribute. It makes these tests generic/020
> generic/337 generic/377 failed. Now add this patch to filter the
> default EA.

What is "the default EA"?  This sounds like a CIFS bug to me.
