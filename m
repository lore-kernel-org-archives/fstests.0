Received: from mail-qt0-f172.google.com ([209.85.216.172]:37471 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbdK0PHX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Nov 2017 10:07:23 -0500
Received: by mail-qt0-f172.google.com with SMTP id d15so39404039qte.4
        for <fstests@vger.kernel.org>; Mon, 27 Nov 2017 07:07:23 -0800 (PST)
Date: Mon, 27 Nov 2017 10:07:21 -0500
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 10/13] fstests: crash consistency fsx test using
 dm-log-writes
Message-ID: <20171127150720.oixyv7vggvjax5m3@destiny>
References: <1504638680-25682-1-git-send-email-amir73il@gmail.com>
 <1504638680-25682-11-git-send-email-amir73il@gmail.com>
 <CAOQ4uxi_SjKCJ97Knvh4S6UiD3jskHEqDja7wwc+-mXp4CNbEw@mail.gmail.com>
 <CAFk8rvZX3YWoShy2i_Jr+-cGt2bhjDxVRaFHgXQNzbmWAkdcXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFk8rvZX3YWoShy2i_Jr+-cGt2bhjDxVRaFHgXQNzbmWAkdcXQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Ashlie Martinez <ashmrtn@utexas.edu>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <jbacik@fb.com>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 27, 2017 at 08:23:49AM -0600, Ashlie Martinez wrote:
> Amir,
> 
> Just to throw in what I believe I've found about dm-log-writes (though
> Josef would know more about this as it's just what I've concluded
> after looking at  the code): dm-log-writes logs at IO completion,
> meaning disks that ignore flush operations could exhibit bugs where
> there are none, and dm-log-writes does synchronous marks though this
> may not line up with the stream of IO operations (due to buffering)
> unless you just did a sync. The CrashMonkey team wanted to make
> something similar to the "mark" operation dm-log-writes has and we
> concluded that the only place we could guarantee a mark would line up
> with the stream of IO operations the user had performed was right
> after a call to sync as that would force cached updates to disk. If
> you call mark without a sync, then you could insert a mark after a
> write(2) returns, but before the delayed allocation for that write(2)
> actually allocates blocks and changes the extent tree on disk.
> 

Yeah dm-log-writes gladly hands you the loaded gun, it's your job to not shoot
yourself with it.  This fsx test is specifically set up to only do the mark
_after_ a successful call of fsync(), which means that the mark will be after
where we expect our data to be consistent.  Thanks,

Josef
